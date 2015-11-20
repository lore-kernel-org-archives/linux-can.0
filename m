From: laurent vaudoit <laurent.vaudoit@gmail.com>
Subject: J1939 crash after receiving BAM frame and no DT frame
Date: Fri, 20 Nov 2015 15:24:57 +0000 (UTC)
Message-ID: <loom.20151120T162359-379@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44482 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbbKTPZL (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 20 Nov 2015 10:25:11 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1ZznYg-00011k-Oz
	for linux-can@vger.kernel.org; Fri, 20 Nov 2015 16:25:06 +0100
Received: from 212.194.216.83 ([212.194.216.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 20 Nov 2015 16:25:06 +0100
Received: from laurent.vaudoit by 212.194.216.83 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 20 Nov 2015 16:25:06 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,
i'm facing some issue on my imx6 board, with j1939 patch.

i setup my can interface with ip link command
and then i setup this interface in j1939

ip link set can0 up type can bitrate 250000
ip link set can0 j1939 on

and after i launch a candump on can0 

On can0, i play an can bus trace (logged from a vehicule).
at the end of the trace, i have a bam frame without the DT frame associated

on the console, i see the log
1939tprx_task timeout on 2 (it seems normal)
and after, i have a rando crash of my system (not in can stuffs, sometimes 
a reset, sometimes nand driver...)

if i remove the BAM frame, problem does not appear.
if i do not set can0 j1939 on, problem does not appear
so it seems the problem is related to j1939 timeout

Is someone yet encountered this problem?

my kernel is a 3.10 kernel, with j1939 patch

Thanks in advance
Best regards

Laurent

