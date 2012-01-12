From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: bridging with can-gw - was Re: recv list
Date: Thu, 12 Jan 2012 19:08:21 +0100
Message-ID: <4F0F2195.7050109@hartkopp.net>
References: <20120109132638.GI386@e-circ.dyndns.org> <loom.20120109T162926-984@post.gmane.org> <20120110085105.GB330@e-circ.dyndns.org> <loom.20120110T112815-928@post.gmane.org> <20120110152341.GD2524@e-circ.dyndns.org> <loom.20120112T155904-850@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:35680 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab2ALSIj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Jan 2012 13:08:39 -0500
In-Reply-To: <loom.20120112T155904-850@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

On 12.01.2012 16:23, Wolfgang wrote:

> is it possible when I create a promiscuous socket with 
> ...
> 
> static struct {
> 	struct sockaddr_can src;
> 	int pkt_len;
> } ss = {
> 	.pkt_len = 1024,
> 	.src.can_addr.j1939 = {
> 		.name = J1939_NO_NAME,
> 		.addr = J1939_NO_ADDR,
> 		.pgn = J1939_NO_PGN,
> 	},
> };
> ....
> addr.can_ifindex = ss.src.can_ifindex;
> ...
> 
> and then receive a msg with recvfrom and  send that msg with sendto to tell 
> the promiscuous socket to ignore the send msg. That the promiscuous socket only
> receives 'extern' messages. I am totally floored, or am I on the wrong track?


Hello Wolfgang,

as you are always writing about the bridging of J1939 frames - what does this
mean on the bus?

Do you only bridge single frames?

If so the kernel based CAN gateway (can-gw) may be something to fit to your
requirements. See:

http://old.nabble.com/netlink-based-CAN-gateway-kernel-module-td27707326.html

The can-gw is in the SocketCAN repos and part of the recently released 
kernel 3.2.

It's performance has been talked about in the 13th Real Time Linux Workshop in
Prague: https://lwn.net/images/conf/rtlws-2011/

PDF is here: https://lwn.net/images/conf/rtlws-2011/paper.22.html

The cangw tool improved since the original posting, see below.

Regards,
Oliver

---8<--- 

Usage: cangw [options]

Commands:  -A (add a new rule)
           -D (delete a rule)
           -F (flush / delete all rules)
           -L (list all rules)
Mandatory: -s <src_dev>  (source netdevice)
           -d <dst_dev>  (destination netdevice)
Options:   -t (preserve src_dev rx timestamp)
           -e (echo sent frames - recommended on vcanx)
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

