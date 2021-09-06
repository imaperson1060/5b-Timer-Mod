//BFDIA 5b
//Character.as
//Purpose: Contains basic code for handling characters.

class Character
{
    var id, x, y, px, py, vx, vy, onob, dire, carry, carryObject, carriedBy, landTimer, deathTimer, charState, standingOn, stoodOnBy, w, h, weight, weight2, h2, atEnd, friction, fricGoal, justChanged, speed, buttonsPressed, pcharState, submerged, temp, heated, heatSpeed;
    function Character(tid, tx, ty, tpx, tpy, tvx, tvy, tonob, tdire, tcarry, tcarryObject, tcarriedBy, tlandTimer, tdeathTimer, tcharState, tstandingOn, tstoodOnBy, tw, th, tweight, tweight2, th2, tatEnd, tfriction, tfricGoal, tjustChanged, tspeed, tbuttonsPressed, tpcharState, tsubmerged, ttemp, theated, theatSpeed)
    {
        id = tid;
        x = tx;
        y = ty;
        px = tx;
        py = ty;
        vx = tvx;
        vy = tvy;
        onob = tonob;
        dire = tdire;
        carry = tcarry;
        carryObject = tcarryObject;
        carriedBy = tcarriedBy;
        landTimer = tlandTimer;
        deathTimer = tdeathTimer;
        charState = tcharState;
        standingOn = tstandingOn;
        stoodOnBy = tstoodOnBy;
        w = tw;
        h = th;
        weight = tweight;
        weight2 = tweight2;
        h2 = th2;
        atEnd = tatEnd;
        friction = tfriction;
        fricGoal = tfricGoal;
        justChanged = tjustChanged;
        speed = tspeed;
        buttonsPressed = tbuttonsPressed;
        pcharState = tpcharState;
        submerged = tsubmerged;
        temp = ttemp;
        heated = theated;
        heatSpeed = theatSpeed;
    } // End of the function
    function applyForces(grav, control, waterUpMaxSpeed) //
    {
        var _loc2;
        if (grav >= 0)
        {
            _loc2 = Math.sqrt(grav);
        } // end if
        if (grav < 0)
        {
            _loc2 = -Math.sqrt(-grav);
        } // end if
        if (!onob && submerged != 1)
        {
            vy = Math.min(vy + _loc2, 25);
        } // end if
        if (onob || control)
        {
            vx = (vx - fricGoal) * friction + fricGoal;
        }
        else
        {
            vx = vx * (1 - (1 - friction) * 0.120000);
        } // end else if
        if (Math.abs(vx) < 0.010000)
        {
            vx = 0;
        } // end if
        if (submerged == 1)
        {
            vy = 0;
            if (weight2 > 0.180000)
            {
                submerged = 2;
            } // end if
        }
        else if (submerged >= 2)
        {
            if (vx > 1.500000)
            {
                vx = 1.500000;
            } // end if
            if (vx < -1.500000)
            {
                vx = -1.500000;
            } // end if
            if (vy > 1.800000)
            {
                vy = 1.800000;
            } // end if
            if (vy < -waterUpMaxSpeed)
            {
                vy = -waterUpMaxSpeed;
            } // end if
        } // end else if
    } // End of the function
    function charMove()
    {
        y = y + vy;
        x = x + vx;
    } // End of the function
    function moveHorizontal(power)
    {
        if (power * fricGoal <= 0 && !onob)
        {
            fricGoal = 0;
        } // end if
        vx = vx + power;
        if (power < 0)
        {
            dire = 1;
        } // end if
        if (power > 0)
        {
            dire = 3;
        } // end if
        justChanged = 2;
    } // End of the function
    function stopMoving()
    {
        if (dire == 1)
        {
            dire = 2;
        } // end if
        if (dire == 3)
        {
            dire = 4;
        } // end if
    } // End of the function
    function jump(jumpPower)
    {
        vy = jumpPower;
    } // End of the function
    function swimUp(jumpPower)
    {
        vy = vy - (weight2 + jumpPower);
    } // End of the function
} // End of Class
