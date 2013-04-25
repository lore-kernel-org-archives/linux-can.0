From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Is there any way of getting the CAN interfaces list, from any
 C program?
Date: Thu, 25 Apr 2013 11:15:47 +0200
Message-ID: <20130425091547.GE448@vandijck-laurijssen.be>
References: <5169B395.2070703@hartkopp.net>
 <516D2ABB.4000300@pengutronix.de>
 <5177A090.6010904@peak-system.com>
 <20130424144929.GA2077@vandijck-laurijssen.be>
 <5178D00C.70507@grandegger.com>
 <5178D638.1010303@pengutronix.de>
 <5178DCC7.9090002@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:63411 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756543Ab3DYJQB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Apr 2013 05:16:01 -0400
Content-Disposition: inline
In-Reply-To: <5178DCC7.9090002@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, Apr 25, 2013 at 09:35:35AM +0200, Marc Kleine-Budde wrote:
> On 04/25/2013 09:07 AM, Marc Kleine-Budde wrote:
> > On 04/25/2013 08:41 AM, Wolfgang Grandegger wrote:
> >> Hi Kurt,
> >>
> >> On 04/24/2013 04:49 PM, Kurt Van Dijck wrote:
> >>> Hi Stephane,
> >>>
> >>> I have written this some time ago, not using it actually.
> >>> I tried a modular approach, don't know if its usefull.
> >>>
> >>> PS: I used attachments.
> >>
> >> ~/enumif$ ./enumif
> >> 1: lo	{loopback} <LOOPBACK,UP,LOWER_UP> UNKNOWN
> >> 2: eth0	{ether} <BROADCAST,MULTICAST> DOWN
> >> 3: eth1	{ether} <BROADCAST,MULTICAST,UP,LOWER_UP> UNKNOWN
> >> 4: eth3	{ether} <NO-CARRIER,BROADCAST,MULTICAST,UP> DOWN
> >> 5: can0	{can} <NOARP,UP,LOWER_UP,ECHO> UNKNOWN
> >> 6: can1	{can} <NOARP,ECHO> DOWN
> >> 7: can2	{can} <NOARP,ECHO> DOWN
> >> 8: can3	{can} <NOARP,ECHO> DOWN
> >> 9: pan0	{ether} <BROADCAST,MULTICAST> DOWN
> >>
> >> Cool! We know that "ip link" does list all network interfaces but the
> >> code doing the job is not really strength-forward. I think this would be
> >> a nice enhancement of the can-utils.
> > 
> > Good idea, Stephane, can you license the code under a permissive license
> > like LGPL or BSD?
> 
> Errr...sorry. It's Kurt, who posted that code.

> Kurt, can you give the code a nice license? :)
What is needed for LGPL or BSD?
Is there a short overview available?

Kurt
