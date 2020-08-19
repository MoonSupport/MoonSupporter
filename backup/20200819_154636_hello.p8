pico-8 cartridge // http://www.pico-8.com
version 29
__lua__


function _init()
	player= {
		sprite_num=1,
		x=59,
		y=59,
		w=8,
		h=8,
		flp=false,
		dx=0,
		dy=0,
		max_dx=2,
		max_dy=3,
		acc=0.5,
		boost=4,
		animation=0,
		running=false ,
		jumping=false ,
		falling=false ,
		sliding=false ,
		landed=false
	}
	
	gravity= 0.3
	friction=0.85

end


cls()
map(0,0)

-->8
function _update()
	player_update()
	--player_animation()
end

function _draw()
	cls()
	map(0,0)
	spr(
	player.sprite_num,
	player.x,
	player.y,
	1,
	1
	)
end
-->8
function collide_map(obj,aim,flag)
		
		local x=obj.x local y=obj.y
		local w=obj.w local h=obj.h
		
		local x1=0 local y1=0
		local x2=0 local y2=0
		
		if aim=="left" then
			x1=x-1 y1=y
			x2=x 		y2=y+h-1
			
		elseif aim=="right" then
			x1=x+h			y1=y
			x2=x+w+1 y2=y+h-1
			
		elseif aim=="up" then
			x1=x+1			y1=y-1
			x2=x+w-1	y2=y
			
		elseif aim=="down" then
			x1=x			y1=y+h
			x2=x+w	y=y+h
		end

	x1/=8			y1/=8
	x2/=8			y2/=8

	if fget(mget(x1,y1), flag)
	or fget(mget(x1,y2), flag)
	or fget(mget(x2,y1), flag)
	or fget(mget(x2,y2), flag) then
		return true
	else
		return false
	end	

end
-->8
function player_update()
	player.dy+=gravity
	player.dx*=friction
	
	--left
	if btn(0) then
		player.dx-=player.acc
		player.running=true
		player.falling=true
	end
	
	--right
	if btn(1) then
		player.dx+=player.acc
		player.running=true
		player.falling=true
	end
	
	if player.running
	and not btn(1)
	and not btn(2)
	and not player.falling
	and not player.jumping then
		player.running=false
		player.sliding=true
	end
	
	-- press x
	if btnp(5)
	and player.landed then
		player.dy-=player.boost
		player.landed=false
	end
	
	if player.dy>0 then
		player.falling=true
		player.landed=false
		player.jumping=false
		
		if collide_map(player,"down",0) then
			player.landed=true
			player.falling=false
			player.dy=0
			player.y-=(player.y+player.h)%8
			end
		elseif player.dy<0 then
			player.jumping=true
			if collide_mapo(player,"up",1)
				player.dy=0
			end
		end	
		
		if player.dx<0 then
			if collide_map(player,"left",1)
				player.dx=0
			end
		else if player.dx>0 then
			if collide_map(player,"right",1) then
				player.dx=0
			end
		end
		
		if player.sliding then
			if abs(player.dx)<.2
			or player.running then
				player.dx=0
				player.sliding=false
			end
		end										
	
	player.x=player.dx
	player.y=player.dy

end
__gfx__
00444440004444400004444400044444000444440004444400044444c00444440000000000000000000000000000000000000000000000000000000000000000
00ccccc000ccccc00ccccccc0c0cccccc00cccccc0cccccc00cccccc0ccccccc0444440000000000000000000000000000000000000000000000000000000000
0cf72f200cf72f20c00ff72fc0cff72fcccff72f0c0ff72f0c0ff72f000ff72f0ccccc0000000000000000000000000000000000000000000000000000000000
0cfffff00cfffef0000ffffe000ffffe000ffffe000ffffec00ffffe000ffffecf72f20000000000000000000000000000000000000000000000000000000000
000cc00000cccc000fcccc000fcccc000fcccc000fcccc0000ccc0000000ccc0cfffef0000000000000000000000000000000000000000000000000000000000
00cccc000f0cc0f00000cc000000cc000000cc000000cc000f0cc0000000cc0f00ccccf000000000000000000000000000000000000000000000000000000000
0f0cd0f0000cd00000cc0d00000cd00000dd0c00000dc00000dc000000000cd00f0ccd0000000000000000000000000000000000000000000000000000000000
00c00d0000c00d0000000d00000cd00000000c00000dc0000dc00000000000cd0000ccdd00000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb000bbbbbbbbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000000
3bbb3bbbbbbb3bbbbbbbb3bbbbbbb3bb0bbbb33b33bb3bb000000000000000000000000000000000000000000000000000000000000000000000000000000000
33b333b33bb33bbbbbbb343bbbbb34bbbb3b33334334bbbb00000000000000000000000000000000000000000000000000000000000000000000000000000000
4b3444343bb343b3bb333443bb3bb4bbbbb3344344443bbb00000000000000000000000000000000000000000000000000000000000000000000000000000000
4b3424443b3444343b3449433b33443bbb3444444464333b00000000000000000000000000000000000000000000000000000000000000000000000000000000
4344444443444944434444434344e443b3444446444443bb00000000000000000000000000000000000000000000000000000000000000000000000000000000
444446444444444444454444444ee444bb3494444444433b00000000000000000000000000000000000000000000000000000000000000000000000000000000
4944444444d444f42444446444444444334444444a44443b00000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444444444444444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44444944444444444444445445444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4444444444554444444944444444e444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44444444444544444444474444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44544444444444444e44477444664444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4444444444444e44444476444d644f44000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4444a44444444ee44477644444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
44444446444444444447444444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333333333334444444444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbbb3bbbbbbbb3bb9999499999999499000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bbb3bbbbbbbb3bbb9994999999994999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333333333334444444444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b3bbbb3bb3bbbbbb9499994994999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
bb3bbb3bbb3bbbbb9949994999499999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
33333333333333334444444444444444000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000049940000499400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000049940000499400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000049940000499400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0033b300003bb3000044940000499400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003333000049940000444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000049940000499400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003b3300003bb3000049440000499400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000049940000499400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
003bb300003bb3000049940000499400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003030303030300000000000000000000030303030000000000000000000000000101010100000000000000000000000001010101000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0070550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0071550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0071550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0071550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0071000000000000005500000000000000004600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0071000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0071000000000000000000000000000000000000000000000000006767000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0071000000000000000000000000000000000000000000000000000067676565656565650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0071000000000000000000650000616061000000000055550065656565656565656565650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0071000000000000000000650000706570000055555555555555555540404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0071000063636500444345000000700070000055555500000000005500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
6571650072736544525050455555700070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4040404040404051505050534340404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5050525350515350505250505150505350505100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
