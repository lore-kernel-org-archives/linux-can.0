From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 crash after receiving BAM frame and no DT frame
Date: Mon, 23 Nov 2015 13:51:37 +0100
Message-ID: <20151123125137.GB25107@airbook.eia.lan>
References: <loom.20151120T162359-379@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:5275 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbbKWMwA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Nov 2015 07:52:00 -0500
Content-Disposition: inline
In-Reply-To: <loom.20151120T162359-379@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>
Cc: linux-can@vger.kernel.org


--- Original message ---
> Date:	Fri, 20 Nov 2015 15:24:57 +0000 (UTC)
> From: laurent vaudoit <laurent.vaudoit@gmail.com>
> To: linux-can@vger.kernel.org
> Subject: J1939 crash after receiving BAM frame and no DT frame
> User-Agent: Loom/3.14 (http://gmane.org/)
> 
> Hi all,
> i'm facing some issue on my imx6 board, with j1939 patch.
> 
> i setup my can interface with ip link command
> and then i setup this interface in j1939
> 
> ip link set can0 up type can bitrate 250000
> ip link set can0 j1939 on
> 
> and after i launch a candump on can0 
> 
> On can0, i play an can bus trace (logged from a vehicule).
> at the end of the trace, i have a bam frame without the DT frame associated
> 
> on the console, i see the log
> 1939tprx_task timeout on 2 (it seems normal)
> and after, i have a rando crash of my system (not in can stuffs, sometimes 
> a reset, sometimes nand driver...)
> 
> if i remove the BAM frame, problem does not appear.
> if i do not set can0 j1939 on, problem does not appear
> so it seems the problem is related to j1939 timeout
> 
> Is someone yet encountered this problem?

I think I never tried this (sending only the BAM without the DATA).
I will take a look one of these days.

Kurt

> 
> my kernel is a 3.10 kernel, with j1939 patch
> 
> Thanks in advance
> Best regards
> 
> Laurent
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
