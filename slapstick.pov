//This is the main source file for the slapstick simulation-- everything you saw in the visualization was scripted and modeled in this one file and no external GUI was used
#include "textures.inc"
#include "shapes.inc"

//Animation script---------------------------------------------------------------------------------------------
#declare Init_Angle = 9.8*0.25/2*180/pi; //Max angle the whip will be extended allowing for precisely 0.5s of freefall
#declare Time = int((frame_number-1)/30);
 
//Extend phase (0:00 - 2:45.5)
#if(clock < 985)
    #declare Angular_Velocity = Init_Angle/165.5;
    #declare Rotation = Init_Angle*(clock/985);
#end    
//Release phase (2:45.5 - 2:46)
#if(clock >= 985 & clock < 988)
    #declare Rotation = Init_Angle-((9.8*pow((0.5*((clock-985)/3)), 2))/2)*180/pi; //2nd rotational kinematic equation
    #declare Angular_Velocity = 9.8*(0.5*((clock-985)/3))*180/pi; //1st rotational kinematic equation
#end    
//End phase (2:46 - 2:48)
#if(clock >= 988)
    #declare Angular_Velocity = 4.9*180/pi; //Display final angular velocity
    #declare Rotation = 0.5*Init_Angle*(sin((clock-988)/12*pi)*exp(-1*((clock-988)/12*pi))); //Recoil after final collision
#end
//End of animation---------------------------------------------------------------------------------------------
                         
                         
                         
//Begin 3d scene---------
camera {
 location <-1, 0.25, -2>
 look_at <0, 0, 0>
}

light_source {
 <500, 500, -500>, color rgb<1, 1, 1>
}

#declare Slapstick =
union {
    difference {
        object {
            Round_Box(<1, 1.75, 1>, <1.1, 2.75, 1.25>, 0.025, 0)
            texture{EMBWood1 scale 0.1 rotate <25, 0, 60>}
            finish{phong 1}
        }
        cylinder {
            <0.95, 1.95, 1.125>, <1.25, 1.975, 1.125> 0.065
            texture{EMBWood1 scale 0.1 rotate <25, 0, 60>}
        }
    }
    object {
            Round_Box(<0.95, 2.25, 1.1>, <1, 2.45, 1.15>, 0.005, 0)
            texture{DMFWood5 scale 0.1 rotate <25, 0, 60>}
            finish{phong 1}
    }
    object {
            Round_Box(<0.9, 2.225, 1.075>, <0.95, 2.475, 1.175>, 0.005, 0)
            texture{DMFWood5 scale 0.1 rotate <25, 0, 60>}
            finish{phong 1}
    }
    box{
        <1.05, 2.75, 1.025>, <1.1, 2.751, 1.225>
        texture{Gold_Metal}
    }
    
    difference{
        cylinder{
            <1.065, 2.75, 1.065>, <1.065, 2.7575, 1.065>, 0.015
            texture{Copper_Metal}
        }
        prism{
            2.751, 2.758, 13,
            <1.065, 1.06>, <1.0575, 1.055>, <1.055, 1.0575>,
            <1.06, 1.065>, <1.055, 1.0725>, <1.0575, 1.075>,
            <1.065, 1.07>, <1.0725, 1.075>, <1.075, 1.0725>,
            <1.07, 1.065>, <1.075, 1.0575>, <1.0725, 1.055>,
            <1.065, 1.06>
            texture{Copper_Metal}   
        }
    }
    
    difference {
        cylinder {
        <1.065, 2.75, 1.185>, <1.065, 2.7575, 1.185>, 0.015
        texture{Copper_Metal}
        }
        prism {
            2.751, 2.758, 13,
            <1.065, 1.06>, <1.0575, 1.055>, <1.055, 1.0575>,
            <1.06, 1.065>, <1.055, 1.0725>, <1.0575, 1.075>,
            <1.065, 1.07>, <1.0725, 1.075>, <1.075, 1.0725>,
            <1.07, 1.065>, <1.075, 1.0575>, <1.0725, 1.055>,
            <1.065, 1.06>
            texture{Copper_Metal}
            translate<0, 0, 0.12>   
        }
    }
    
}

union {
    object {
        Slapstick
        translate <-1.1, -2.75, -1.125>
        rotate <0, 0, -1*Rotation>
    }
    object {
        Slapstick
        translate <-1.1, -2.75, -1.125>
        scale <-1, 0, 0>
        rotate <0, 0, Rotation>
    }
    
    //Hinges
    cylinder {
        <0, 0.01, -0.075>, <0, 0.01, -0.025>, 0.015
        texture{Gold_Metal}
    }
    cylinder {
        <0, 0.01, 0.075>, <0, 0.01, 0.025>, 0.015
        texture{Gold_Metal}
    }
    cylinder {
        <0, 0.01, -0.1>, <0, 0.01, 0.1>, 0.01
        texture{Gold_Metal}
    }
}

//Text objects for displaying angle, angular velocity, and time
//Display Angle
text{
    ttf "timrom.ttf",
    "Angle:",0.5, 0
    pigment{rgb<1, 0, 0>}
    scale 0.2
    rotate<-10, 0, 5>
    translate<-1.15, 0.75, 0>
}
text{
    ttf "timrom.ttf",
    str(Rotation, 3, 2),0.5, 0
    pigment{rgb<1, 0, 0>}
    scale 0.2
    rotate<-10, 0, 5>
    translate<-0.55, 0.8, 0>
}

#if(Rotation < 10)
    text{
        ttf "timrom.ttf",
        "o",0.5, 0
        pigment{rgb<1, 0, 0>}
        scale 0.1
        rotate<-10, 0, 5>
        translate<-0.15, 0.95, 0>
    }
#else
    text{
        ttf "timrom.ttf",
        "o",0.5, 0
        pigment{rgb<1, 0, 0>}
        scale 0.1
        rotate<-10, 0, 5>
        translate<-0.06, 0.95, 0>
    }
#end

//Display Angular Velocity
text{
    ttf "timrom.ttf",
    "Velocity(  ):",0.5, 0
    pigment{rgb<0, 1, 0>}
    scale 0.1
    rotate<-10, 0, 5>
    translate<-1.15, 0.575, 0>
}
text{
    ttf "timrom.ttf",
    "o",0.5, 0
    pigment{rgb<0, 1, 0>}
    scale 0.045
    rotate<-10, 0, 5>
    translate<-0.76, 0.66, 0>
}
text{
    ttf "timrom.ttf",
    "_",0.5, 0
    pigment{rgb<0, 1, 0>}
    scale 0.065
    rotate<-10, 0, 5>
    translate<-0.7675, 0.6575, 0>
}
text{
    ttf "timrom.ttf",
   "s",0.5, 0
    pigment{rgb<0, 1, 0>}
    scale 0.065
    rotate<-10, 0, 5>
    translate<-0.76, 0.595, 0>
}

text{
    ttf "timrom.ttf",
    str(Angular_Velocity, 3, 2),0.5, 0
    pigment{rgb<0, 1, 0>}
    scale 0.2
    rotate<-10, 0, 5>
    translate<-0.65, 0.6, 0>
}

text{
    ttf"timrom.ttf"
    "t= ", 0.5, 0
    pigment{rgb<1, 1, 1>}
    scale 0.1
    rotate<0, 0, 0>
    translate<-1.225, 0.025, -0.05>
}

text{
    ttf"timrom.ttf"
    "t= ", 0.5, 0
    pigment{rgb<1, 1, 1>}
    scale 0.1
    rotate<0, 0, 0>
    translate<-1.225, 0.025, -0.05>
}

text{
    ttf"timrom.ttf"
    str(Time, 0, 0), 0.5, 0
    pigment{rgb<1, 1, 1>}
    scale 0.1
    rotate<0, 0, 0>
    translate<-1.125, 0.025, -0.05>
}

//Display time
#if(Time < 10)
text{
    ttf"timrom.ttf"
    "s", 0.5, 0
    pigment{rgb<1, 1, 1>}
    scale 0.1
    rotate<0, 0, 0>
    translate<-1.065, 0.025, -0.05>
}
#end

#if(Time >= 10 & Time <  100)
text{
    ttf"timrom.ttf"
    "s", 0.5, 0
    pigment{rgb<1, 1, 1>}
    scale 0.1
    rotate<0, 0, 0>
    translate<-1.015, 0.025, -0.05>
}
#end

#if(Time >= 100)
text{
    ttf"timrom.ttf"
    "s", 0.5, 0
    pigment{rgb<1, 1, 1>}
    scale 0.1
    rotate<0, 0, 0>
    translate<-0.96, 0.025, -0.05>
}
#end

//X-Y Plane
cylinder{
 <0, 5, 0>, <0, -5, 0>, 0.01
 pigment{color rgb <1, 0, 0>}
}
cylinder{
 <5, 0, 0>, <-5, 0, 0>, 0.01
 pigment{color rgb <0, 0, 1>}
}
