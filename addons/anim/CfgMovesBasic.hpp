class CfgMovesBasic
{
    class Default;
    // class StandBase;
    class HealBase: Default
    {
        disableWeapons=1;
        disableWeaponsLong=1;
        showWeaponAim=0;
        canPullTrigger=0;
        duty=0.2;
        limitGunMovement=0;
        aiming="empty";
        aimingBody="empty";
        actions="HealActionBase";
        looped=0;
    };
    class ManActions
    {
        Disable_Gesture[]=
        {
            "Disable_Gesture",
            "Gesture"
        };
        GVAR(cig_in)[]=
        {
            QGVAR(cig_in),
            "Gesture"
        };
        GVAR(cig_loop)[]=
        {
            QGVAR(cig_loop),
            "Gesture"
        };
        GVAR(cig_out)[]=
        {
            QGVAR(cig_out),
            "Gesture"
        };
    };
    class Actions
    {
        // class Default;
        class NoActions;
        class Controlled_ActionStances_p: NoActions
        {
            stop="Controlled_idle_p";
            default="Controlled_idle_p";
            stopRelaxed="Controlled_idle_p";
            TurnL="Controlled_idle_p";
            TurnR="Controlled_idle_p";
            TurnLRelaxed="Controlled_idle_p";
            TurnRRelaxed="Controlled_idle_p";
            WalkF="Controlled_walkF";
            PlayerWalkF="Controlled_walkF";
            WalkLF="Controlled_walkFl";
            PlayerWalkLF="Controlled_walkFl";
            WalkRF="Controlled_walkFr";
            PlayerWalkRF="Controlled_walkFr";
            WalkL="Controlled_walkL";
            PlayerWalkL="Controlled_walkL";
            WalkR="Controlled_walkR";
            PlayerWalkR="Controlled_walkR";
            WalkB="Controlled_walkB";
            PlayerWalkB="Controlled_walkB";
            WalkLB="Controlled_walkBL";
            PlayerWalkLB="Controlled_walkBL";
            WalkRB="Controlled_walkBR";
            PlayerWalkRB="Controlled_walkBR";
            combat="Controlled_walkF";
            up="Controlled_walkF";
            down="Controlled_walkF";
            gear="Controlled_walkF";
            upDegree="ManPosNoWeapon";
        };
    };
};



class CfgGesturesMale
{
    class ManActions
    {
    };
    // class Actions;
    class Default;
    class BlendAnims {
        am_leftHalfBody[]=
        {
            "RightShoulder",
            1,
            "head",
            1,
            "neck1",
            1,
            "neck",
            1,
            "LeftShoulder",
            1,
            "LeftArm",
            1,
            "LeftArmRoll",
            1,
            "LeftForeArm",
            1,
            "LeftForeArmRoll",
            1,
            "LeftHand",
            1,
            "LeftHandRing",
            1,
            "LeftHandPinky1",
            1,
            "LeftHandPinky2",
            1,
            "LeftHandPinky3",
            1,
            "LeftHandRing1",
            1,
            "LeftHandRing2",
            1,
            "LeftHandRing3",
            1,
            "LeftHandMiddle1",
            1,
            "LeftHandMiddle2",
            1,
            "LeftHandMiddle3",
            1,
            "LeftHandIndex1",
            1,
            "LeftHandIndex2",
            1,
            "LeftHandIndex3",
            1,
            "LeftHandThumb1",
            1,
            "LeftHandThumb2",
            1,
            "LeftHandThumb3",
            1,
            "Spine",
            1,
            "Spine1",
            1,
            "Spine2",
            1,
            "Spine3",
            1,
            "pelvis",
            "MaskStart"
        };
        am_leftHandActual[]=
        {
            "LeftShoulder",
            1,
            "LeftArm",
            1,
            "LeftArmRoll",
            1,
            "LeftForeArm",
            1,
            "LeftForeArmRoll",
            1,
            "LeftHand",
            1,
            "LeftHandRing",
            1,
            "LeftHandPinky1",
            1,
            "LeftHandPinky2",
            1,
            "LeftHandPinky3",
            1,
            "LeftHandRing1",
            1,
            "LeftHandRing2",
            1,
            "LeftHandRing3",
            1,
            "LeftHandMiddle1",
            1,
            "LeftHandMiddle2",
            1,
            "LeftHandMiddle3",
            1,
            "LeftHandIndex1",
            1,
            "LeftHandIndex2",
            1,
            "LeftHandIndex3",
            1,
            "LeftHandThumb1",
            1,
            "LeftHandThumb2",
            1,
            "LeftHandThumb3",
            1,
            "pelvis",
            "MaskStart"
        };
    };
    class States
    {
        class Disable_Gesture: Default
        {
            speed=1;
            file="\A3\anims_f\Data\Anim\Sdr\mov\erc\stp\non\non\AmovPercMstpSnonWnonDnon.rtm";
            disableWeapons=0;
            disableWeaponsLong=0;
            interpolationRestart=2;
            weaponIK=1;
            looped=0;
            enableOptics = 1;
            leftHandIKBeg=1;
            leftHandIKCurve[]={1};
            leftHandIKEnd=1;
            rightHandIKBeg=1;
            rightHandIKCurve[]={1};
            rightHandIKEnd=1;
        };
        class GVAR(cig_in): Default
        {
            speed=-4.5;
            looped=0;
            mask="handsWeapon_context";
            file=QPATHTOF(data\cig_in.rtm);      //"\immersion_cigs_animations\cig_in.rtm"
            leftHandIKBeg=0;
            leftHandIKCurve[]={0};
            leftHandIKEnd=0;
            rightHandIKBeg=0;
            rightHandIKCurve[]={0};
            rightHandIKEnd=0;
        };
        class GVAR(cig_out): Default
        {
            speed=-1.9;
            looped=0;
            mask="handsWeapon_context";
            file=QPATHTOF(data\cig_out.rtm);      //"\immersion_cigs_animations\cig_out.rtm";
            leftHandIKBeg=0;
            leftHandIKCurve[]={0};
            leftHandIKEnd=0;
            rightHandIKBeg=0;
            rightHandIKCurve[]={0};
            rightHandIKEnd=0;
        };
        class GVAR(cig_loop): Default
        {
            speed=-6.5;
            looped=1;
            mask="am_leftHalfBody";
            file=QPATHTOF(data\cig_loop.rtm);      //"\immersion_cigs_animations\cig_loop.rtm";
            leftHandIKBeg=0;
            leftHandIKCurve[]={0};
            leftHandIKEnd=0;
            rightHandIKBeg=0;
            rightHandIKCurve[]={0};
            rightHandIKEnd=0;
        };
    };
};


class CfgMovesMaleSdr: CfgMovesBasic
{
    skeletonName="OFP2_ManSkeleton";
    gestures="CfgGesturesMale";
    class States
    {
        class AmovPercMstpSlowWpstDnon;
        class Controlled_idle_p: AmovPercMstpSlowWpstDnon
        {
            canReload = 0;
            file = "a3\anims_f_jets\anim\acts_jets_crewaidl_idle_m.rtm";
            collisionShape="A3\anims_f\Data\Geom\Sdr\Perc_Wnon.p3d";
            speed = 0.4225;
            showItemInHand = 1;
            duty = 0;
            mask="BodyFull";
            weaponIK=0;
            enableOptics=0;
            showWeaponAim=0;
            disableWeapons=1;
            disableWeaponsLong=1;
            leaning="empty";
            aimingBody="empty";
            aiming="empty";
            canPullTrigger=1;
            weaponLowered=0;
            limitGunMovement = 1;
            showHandGun=0;
            actions="Controlled_ActionStances_p";
            head = "headNo";
            minPlayTime = 0;
            variantsPlayer[]=
            {
            };
            variantsAI[]=
            {
            };
            ConnectTo[]=
            {
            };
            ConnectFrom[]=
            {
            };
            InterpolateTo[]=
            {
                "Controlled_idle_p",
                0.0099999998,
                "Controlled_walkF",
                0.0099999998,
                "Controlled_walkB",
                0.0099999998,
                "Controlled_walkFl",
                0.0099999998,
                "Controlled_walkFr",
                0.0099999998,
                "Controlled_walkL",
                0.0099999998,
                "Controlled_walkR",
                0.0099999998,
                "Controlled_walkBR",
                0.0099999998,
                "Controlled_walkBL",
                0.0099999998,
                "AmovPercMstpSnonWnonDnon",
                0.00002
            };
            InterpolateFrom[]=
            {
                "Controlled_idle_p",
                0.0099999998,
                "Controlled_walkF",
                0.0099999998,
                "Controlled_walkB",
                0.0099999998,
                "Controlled_walkFl",
                0.0099999998,
                "Controlled_walkFr",
                0.0099999998,
                "Controlled_walkL",
                0.0099999998,
                "Controlled_walkR",
                0.0099999998,
                "Controlled_walkBR",
                0.0099999998,
                "Controlled_walkBL",
                0.0099999998
            };

        };
        class Controlled_walkF: Controlled_idle_p
        {
            file = "a3\anims_f\data\anim\sdr\mov\erc\wlk\non\non\amovpercmwlksnonwnondf.rtm";
            soundEdge[]={0.25,0.5,0.75,1};
            soundOverride="run";
            speed = 0.26;
            visibleSize=0.89999998;
            aimPrecision=2;
            static=1;
            relSpeedMin=0.80000001;
            soundEnabled=1;
        };
        class Controlled_walkB: Controlled_walkF
        {
            file = "a3\anims_f\data\anim\sdr\mov\erc\wlk\non\non\amovpercmwlksnonwnondb.rtm";
            soundEdge[] = {0.25,0.5,0.75,1};
            speed = 0.337079;
        };
        class Controlled_walkBL: Controlled_walkF
        {
            file = "a3\anims_f\data\anim\sdr\mov\erc\wlk\non\non\amovpercmwlksnonwnondbl.rtm";
            soundEdge[] = {0.25,0.5,0.75,1};
            speed = 0.337079;
        };
        class Controlled_walkBR: Controlled_walkF
        {
            file = "a3\anims_f\data\anim\sdr\mov\erc\wlk\non\non\amovpercmwlksnonwnondbr.rtm";
            soundEdge[] = {0.25,0.5,0.75,1};
            speed = 0.337079;
        };
        class Controlled_walkFl: Controlled_walkF
        {
            file = "a3\anims_f\data\anim\sdr\mov\erc\wlk\non\non\amovpercmwlksnonwnondfl.rtm";
            soundEdge[] = {0.25,0.5,0.75,1};
            speed = 0.3;
        };
        class Controlled_walkFr: Controlled_walkF
        {
            file = "a3\anims_f\data\anim\sdr\mov\erc\wlk\non\non\amovpercmwlksnonwnondfr.rtm";
            soundEdge[] = {0.25,0.5,0.75,1};
            speed = 0.3;
        };
        class Controlled_walkL: Controlled_walkF
        {
            file = "a3\anims_f\data\anim\sdr\mov\erc\wlk\non\non\amovpercmwlksnonwnondl.rtm";
            soundEdge[] = {0.25,0.5,0.75,1};
            speed = 0.47619;
        };
        class Controlled_walkR: Controlled_walkF
        {
            file = "a3\anims_f\data\anim\sdr\mov\erc\wlk\non\non\amovpercmwlksnonwnondr.rtm";
            soundEdge[] = {0.25,0.5,0.75,1};
            speed = 0.483871;
        };
    };
};
