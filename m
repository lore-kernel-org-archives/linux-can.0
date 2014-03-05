From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: c_can: wrong frame order reception
Date: Wed, 05 Mar 2014 15:58:09 +0100
Message-ID: <2323199.vffRdFDsB5@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:34882 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758442AbaCEPHw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 5 Mar 2014 10:07:52 -0500
Received: from comm.systec-electronic.de (unknown [212.185.67.148])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 41DA727A626
	for <linux-can@vger.kernel.org>; Wed,  5 Mar 2014 15:02:45 +0100 (CET)
Received: from ws-stein.localnet (unknown [192.168.10.118])
	by comm.systec-electronic.de (Postfix) with ESMTP id 330E297C275
	for <linux-can@vger.kernel.org>; Wed,  5 Mar 2014 15:58:33 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I tried using the c_can[_pci] driver for the PCH (aka EG20T) thus trying a 
different driver than pch_can.
Using 2 modules doing some CAN frame bursts ( I guess for a short time the bus 
load is near 100%) on the bus I noticed out of order reception. Each of the 
sent frames has a counter, increasing with each frame and a distinctive CAN-
ID. I attached those 2 patches I'm currently on.
1st: Support for eg20t within c_can
2nd: My debug output
Not attached as patch: I disabled MSI. I suppose there is a problem with that. 
But I can't check that when reading CAN frames is broken.

Here is some interesting output:
[ 3716.163618] c_can_pci 0000:02:0c.3 can0: 0x252 20 95
[ 3716.163721] c_can_pci 0000:02:0c.3 can0: 0x252 20 96
[ 3716.163943] c_can_pci 0000:02:0c.3 can0: 0x252 20 97
[ 3716.164067] c_can_pci 0000:02:0c.3 can0: 0x252 20 98
[ 3716.164164] c_can_pci 0000:02:0c.3 can0: free lower

[ 3716.164395] c_can_pci 0000:02:0c.3 can0: 0x252 20 9a
[ 3716.164476] c_can_pci 0000:02:0c.3 can0: 0x252 20 99

[ 3716.164671] c_can_pci 0000:02:0c.3 can0: 0x252 20 9b
[ 3716.164769] c_can_pci 0000:02:0c.3 can0: 0x252 20 9c
[ 3716.165041] c_can_pci 0000:02:0c.3 can0: 0x252 20 9d
[ 3716.165090] c_can_pci 0000:02:0c.3 can0: free lower

I separated the switched ones.
My observations:
Frame with counter "20 98" is in message box C_CAN_MSG_RX_LOW_LAST thus 
freeing all lower boxes ("free lower").
c_can_do_rx_poll will then check the next box C_CAN_MSG_RX_LOW_LAST + 1 which 
is (still) empty. All following message boxes are empty.
The next time the first message box is checked, which is 20 9a. All following 
boxes are empty until C_CAN_MSG_RX_LOW_LAST + 1 which is now has the frame 
with counter 20 99.
Starting with 20 9b all goes the normal way.

I guess that while te lower boxes are freed the new frame with counter 9a is 
about to be inserted in box C_CAN_MSG_RX_LOW_LAST + 1. But when this box is 
checked afterwards the corresponding bit is yet set in C_CAN_INTPND1_REG thus 
ignoring this box now.

Anybody has an idea how to fix that?

I'm currently running on a patched v3.10.32-rt31-rebase kernel. RT-preempt is 
active but I doubt this has any influence here.

Best regards
Alexander

