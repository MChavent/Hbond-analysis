# Matthieu Chavent 1 Sept. 2020
# create a hbond using dashed cylinder
# create_hbond_capped <molid> <atom index 1> <atom index 2> <color> <Material> <cylinder radius = bond thickness> <length of empty space/cylinder >
#  example: create_hbond_capped top "index 7796" "index 1324" yellow Opaque 0.1 0.3
# remove the hbonds: graphics <molid> delete all

proc create_hbond_capped {molID sel1 sel2 color material size hlength} {


	set selec1 [atomselect $molID "$sel1"]
	set selec2 [atomselect $molID "$sel2"]

	set coord_selec1 [measure center $selec1]
	set coord_selec2 [measure center $selec2]

	set distance [veclength [vecsub $coord_selec1 $coord_selec2 ]]
	set vecnorm [vecnorm [vecsub $coord_selec2 $coord_selec1]]
	
	set nb_dash [expr int( $distance / $hlength )]

	puts "$distance"
	puts "$nb_dash"

 	for { set id 0 } { $id < $nb_dash  } { incr id 1 } {
		set scale1 [expr $hlength*$id]
		set scale2 [expr $hlength*($id+1)]
		
		set coord1 [vecadd $coord_selec1 [vecscale $scale1 $vecnorm]]
		set coord2 [vecadd $coord_selec1 [vecscale $scale2 $vecnorm]]


		graphics $molID color $color
		graphics $molID material $material

		# if you do not want the spheres to cap the cylinder, comment the 2 next lines
		graphics $molID sphere $coord1 radius $size resolution 23
		graphics $molID sphere $coord2 radius $size resolution 23

		if {$id%2 == 1} {
			graphics $molID cylinder $coord1 $coord2 radius $size resolution 23 filled yes
		}

	
	}
	
}

