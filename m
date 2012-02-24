From: Wolfgang Wagner <wutz@unterderbruecke.de>
Subject: Transport Protocol
Date: Fri, 24 Feb 2012 15:23:10 +0000 (UTC)
Message-ID: <loom.20120224T154038-289@post.gmane.org>
References: <4F0F2195.7050109@hartkopp.net> <20120113111251.GD319@e-circ.dyndns.org> <loom.20120113T122554-557@post.gmane.org> <loom.20120116T103812-141@post.gmane.org> <20120116133140.GA26427@e-circ.dyndns.org> <loom.20120116T153805-349@post.gmane.org> <20120116153644.GA7763@e-circ.dyndns.org> <loom.20120207T160415-497@post.gmane.org> <20120208084602.GA412@e-circ.dyndns.org> <loom.20120216T104829-444@post.gmane.org> <20120216194911.GA447@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:52182 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055Ab2BXPX2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 24 Feb 2012 10:23:28 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1S0wzS-0001U3-4U
	for linux-can@vger.kernel.org; Fri, 24 Feb 2012 16:23:22 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 24 Feb 2012 16:23:22 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 24 Feb 2012 16:23:22 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Kurt,

I try to bridge a Multi Packet Message. 


I set can0 on j1939 and started it

$echo can0 > /proc/net/can-j1939/net
$ip link set can0 up type can bitrate 500000
$ip addr add j1939 0x00 dev can0


I am still working with the simulator software.
Now sent the TP.CM 0x1CEC009F 0x16 0x00 0xF0 0x30 0xFF 0x00 0xEE 0x00


Now it responses with this:
0X1CEC9F00 0xFF 0x05 0xFF 0xFF 0xFF 0x00 0xEE 0x00

and I get this message:
$j1939xtp_rx_bad_message, pgn 0ee00
$j1939xtp_rx_abort 2, 0ee00


I am pretty sure I did something wrong, can you please correct?

Is it possible if everything is done right to bridge the TP.CM and TP.DT
directly with the previous implementation?

