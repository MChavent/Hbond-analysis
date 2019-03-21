#  inter2beta.tcl
#  
#  Created by Matthieu Chavent (2018-2019).
#
# use: inter2beta top <VMD selection for protein> <VMD selection for protein2> <data file created by the H-bond_analysis script for protein1> <data file created by the H-bond_analysis script for protein2>


proc inter2beta {MolID sel1 sel2 file_dat1 file_dat2} {

	set all [atomselect $MolID "all"]
	$all set beta 0.011

	set liste_lect ""
	set liste_tenC ""


	set fp_lect [open $file_dat1 r]
	set file_data_lect [read $fp_lect]
	close $fp_lect

	set data_lect [split $file_data_lect "\n"]
	set data_lect [lreplace $data_lect end end]

	set list_res_lect ""
	set list_inter_lect ""

	foreach elt $data_lect {
		set data [split $elt]
		lappend list_res_lect [lindex $data 0]
		lappend list_inter_lect [lindex $data 1]
	}

	#puts $list_res_lect
	#puts $list_inter_lect

	for {set i 0} {$i < [expr [llength $list_res_lect]]} {incr i} {

		set res_nb [lindex $list_res_lect $i]
		set inter [lindex $list_inter_lect $i]
    		set res [atomselect $MolID "$sel1 and resid $res_nb"]
		if {$inter > 0.011} { 
    			$res set beta $inter
		}
	}

	set fp_ten [open $file_dat1 r]
	set file_data_ten [read $fp_ten]
	close $fp_ten

	set data_ten [split $file_data_ten "\n"]
	set data_ten [lreplace $data_ten end end]

	set list_res_ten ""
	set list_inter_ten ""

	foreach elt $data_ten {
		set data [split $elt]
		lappend list_res_ten [lindex $data 0]
		lappend list_inter_ten [lindex $data 1]
	}


	for {set i 0} {$i < [expr [llength $list_res_ten]]} {incr i} {

		set res_nb [lindex $list_res_ten $i]
		set inter [lindex $list_inter_ten $i]
    		set res [atomselect $MolID "$sel2 and resid $res_nb"]
		if {$inter > 0.011} { 
    			$res set beta $inter
		}
	}
}



