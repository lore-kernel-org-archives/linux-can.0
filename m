From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: AW: AW: netlink error -95 (Operation not supported) with can-utils/cangw
Date: Tue, 04 Feb 2014 19:19:54 +0100
Message-ID: <52F12F4A.9040504@hartkopp.net>
References: <18F8639CFC8C7C4D819AB347808079D4026C69FC@pluto.office.rac.de> <52F0D101.6050500@hartkopp.net> <18F8639CFC8C7C4D819AB347808079D4026C6A12@pluto.office.rac.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:45773 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792AbaBDST4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2014 13:19:56 -0500
In-Reply-To: <18F8639CFC8C7C4D819AB347808079D4026C6A12@pluto.office.rac.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Sandro Anders | CarMedialab <sandro.anders@carmedialab.com>
Cc: linux-can@vger.kernel.org

On 04.02.2014 13:02, Sandro Anders | CarMedialab wrote:
> 
> Is there any documentation?
> 

Hi Sandro,

it's mostly 'documented by sourcecode' :-)

E.g. the netlink interface is described here:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/can/gw.h

and the cangw tool (which C-file is a good example too) has a big help text:

$ cangw 

Usage: cangw [options]

Commands:  -A (add a new rule)
           -D (delete a rule)
           -F (flush / delete all rules)
           -L (list all rules)
Mandatory: -s <src_dev>  (source netdevice)
           -d <dst_dev>  (destination netdevice)
Options:   -t (preserve src_dev rx timestamp)
           -e (echo sent frames - recommended on vcanx)
           -i (allow to route to incoming interface)
           -l <hops> (limit the number of frame hops / routings)
           -f <filter> (set CAN filter)
           -m <mod> (set frame modifications)
           -x <from_idx>:<to_idx>:<result_idx>:<init_xor_val> (XOR checksum)
           -c <from>:<to>:<result>:<init_val>:<xor_val>:<crctab[256]> (CRC8 cs)
           -p <profile>:[<profile_data>] (CRC8 checksum profile & parameters)

Values are given and expected in hexadecimal values. Leading 0s can be omitted.

<filter> is a <value><mask> CAN identifier filter
   <can_id>:<can_mask> (matches when <received_can_id> & mask == can_id & mask)
   <can_id>~<can_mask> (matches when <received_can_id> & mask != can_id & mask)

<mod> is a CAN frame modification instruction consisting of
<instruction>:<can_frame-elements>:<can_id>.<can_dlc>.<can_data>
 - <instruction> is one of 'AND' 'OR' 'XOR' 'SET'
 - <can_frame-elements> is _one_ or _more_ of 'I'dentifier 'L'ength 'D'ata
 - <can_id> is an u32 value containing the CAN Identifier
 - <can_dlc> is an u8 value containing the data length code (0 .. 8)
 - <can_data> is always eight(!) u8 values containing the CAN frames data
The max. four modifications are performed in the order AND -> OR -> XOR -> SET

Example:
cangw -A -s can0 -d vcan3 -e -f 123:C00007FF -m SET:IL:333.4.1122334455667788

Supported CRC 8 profiles:
Profile '1' (1U8)       - add one additional u8 value
Profile '2' (16U8)      - add u8 value from table[16] indexed by (data[1] & 0xF)
Profile '3' (SFFID_XOR) - add u8 value (can_id & 0xFF) ^ (can_id >> 8 & 0xFF)

$ _

The idea behind the output format of 'cangw -L' is, that all the routing jobs
can be re-directed into a (script-)file to set up the configuration again.

Regards,
Oliver

