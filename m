From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 10/10] can: c_can : Disable rx split as workaround
Date: Sat, 5 Apr 2014 20:56:04 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1404051538110.14882@ionos.tec.linutronix.de>
References: <20140404134816.751883017@linutronix.de> <20140404134858.173427806@linutronix.de> <533EDB36.6060404@del-llc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45287 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372AbaDESzy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 5 Apr 2014 14:55:54 -0400
In-Reply-To: <533EDB36.6060404@del-llc.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mark <mark5@del-llc.com>
Cc: linux-can <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>

On Fri, 4 Apr 2014, Mark wrote:

> Thomas:  a few comments on my experience with the CAN driver:
> 
> I think I agree with your approach -- I had the same problem losing a packet
> when running through the clearing of the newdat flags.
> 
> About a month ago, I re-wrote pch_can.c  (before I discovered this mailing
> list) and got it to work successfully sending / receiving CAN data at 1 MBIT

Wow, that's amazing.

That driver is just a variant of c_can.c with quite some of the same
bugs and some different ones.

We really should switch that over to c_can.c and get rid of it.

Thanks,

	tglx



