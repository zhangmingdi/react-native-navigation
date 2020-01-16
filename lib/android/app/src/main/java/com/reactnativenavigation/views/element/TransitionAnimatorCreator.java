package com.reactnativenavigation.views.element;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.AnimatorSet;

import com.reactnativenavigation.parse.AnimationOptions;
import com.reactnativenavigation.utils.ViewUtils;
import com.reactnativenavigation.viewcontrollers.ViewController;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static com.reactnativenavigation.utils.CollectionUtils.*;

public class TransitionAnimatorCreator {

    public AnimatorSet create(ViewController toScreen, AnimationOptions fadeAnimation, TransitionSet transitions) {
//        if (transitions.isEmpty()) return new AnimatorSet();
        Collection<Animator> animators = new ArrayList<>();
        animators.addAll(createSharedElementTransitionAnimators(toScreen, transitions.validSharedElementTransitions));
        animators.addAll(createElementTransitionAnimators(transitions.validElementTransitions));
        for (Animator set : animators) {
            for(Animator animator : ((AnimatorSet) set).getChildAnimations()) {
                animator.setDuration(fadeAnimation.getDuration());
            }
        }

//        for (ElementTransitionOptions transition : transitions.validElementTransitions) {
//            View fromView = from.get(transition.getId());
//            View toView = to.get(transition.getId());
//            ViewController screen = fromView == null ? toScreen : fromScreen;
//            animators.add(create(fadeAnimation, transition, screen, ObjectUtils.take(fromView, toView)));
//        }
        AnimatorSet set = new AnimatorSet();
        set.addListener(new AnimatorListenerAdapter() {
            @Override
            public void onAnimationEnd(Animator animation) {
                restoreViewsToOriginalState();
            }

            @Override
            public void onAnimationCancel(Animator animation) {
                restoreViewsToOriginalState();
            }

            private void restoreViewsToOriginalState() {
                forEach(transitions.validSharedElementTransitions, transition -> {
                    toScreen.removeOverlay(transition.to);
                    ViewUtils.returnToOriginalParent(transition.to);
                    transition.from.setAlpha(1);
                });
                forEach(transitions.validElementTransitions, transition -> {
//                    toScreen.removeOverlay(transition.getView());
//                    ViewUtils.returnToOriginalParent(transition.getView());
//                    transition.getFromView(from).setAlpha(1);
                });
            }
        });
        set.playTogether(animators);
        return set;
    }


    private List<AnimatorSet> createSharedElementTransitionAnimators(ViewController toScreen, List<SharedElementTransition> transitions) {
        List<AnimatorSet> animators = new ArrayList<>();
        for (SharedElementTransition transition : transitions) {
            animators.add(createSharedElementAnimator(toScreen, transition));
        }
        return animators;
    }

    private AnimatorSet createSharedElementAnimator(ViewController toScreen, SharedElementTransition transition) {
        ViewUtils.reparent(transition.to, child -> toScreen.requireParentController().addOverlay(child));
        AnimatorSet set = new AnimatorSet();
        set.playTogether(transition.createAnimators());
        set.addListener(new AnimatorListenerAdapter() {
            @Override
            public void onAnimationStart(Animator animation) {
                transition.from.setAlpha(0);
            }
        });
        return set;
    }

    private List<AnimatorSet> createElementTransitionAnimators(List<ElementTransition> transitions) {
//        ViewUtils.reparent(view, screen::addOverlay);
        List<AnimatorSet> animators = new ArrayList<>();
        for (ElementTransition transition : transitions) {
            animators.add(transition.createAnimators());
        }
        return animators;
    }
}
