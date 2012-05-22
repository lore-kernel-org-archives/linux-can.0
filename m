From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: certain CAN frames not being read ok
Date: Tue, 22 May 2012 18:56:30 +0200
Message-ID: <4FBBC53E.1050901@grandegger.com>
References: <CABHoAvkZcMDi30MmYr+zYP=QTR_u5DxJ-5ib07L44KOQk8sVAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:36926 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab2EVQ4e (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 May 2012 12:56:34 -0400
In-Reply-To: <CABHoAvkZcMDi30MmYr+zYP=QTR_u5DxJ-5ib07L44KOQk8sVAA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Economides <mecono@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 05/22/2012 02:37 AM, Michael Economides wrote:
> Hello,
> 
> I am reading CAN frames using read()
> 
> 	nbytes = read(s, &rframe, sizeof(rframe));
> 
> Sometimes it works fine.  For example these frames are read ok:
> 
> 123#44 33 33 33 33 33 33 44
> 112#05 01 01 01 22 22 33 33
> 
> However, this frame causes an "Ack slot" error:
> 
> 123#01 00 00 00 00 00 00 00
> 
> Any ideas what could cause this?

This could be due to hardware problems on the CAN bus. Please check:

- bittiming.
- bus termination.

What does "candump -e any,0:0,#FFFFFFFF" report while you receive data?
And what CAN hardware are you using (what does "ip -d -s link show can0"
report)?

Wolfgang.


