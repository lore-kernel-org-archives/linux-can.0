From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Is there any way of getting the CAN interfaces list, from any
 C program?
Date: Thu, 25 Apr 2013 11:14:21 +0200
Message-ID: <20130425091421.GD448@vandijck-laurijssen.be>
References: <5169B395.2070703@hartkopp.net>
 <516D2ABB.4000300@pengutronix.de>
 <5177A090.6010904@peak-system.com>
 <20130424144929.GA2077@vandijck-laurijssen.be>
 <5178D00C.70507@grandegger.com>
 <20130425072429.GA448@vandijck-laurijssen.be>
 <5178DE98.7040408@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:58230 "EHLO
	mailrelay009.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753841Ab3DYJO0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Apr 2013 05:14:26 -0400
Content-Disposition: inline
In-Reply-To: <5178DE98.7040408@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Stephane Grosjean <s.grosjean@peak-system.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

I was just thinking that it has not that much to do with CAN altogether,
and may deserve a seperate git tree.

I'm just rewriting the code a bit to work without callback, and be more like
if_nameindex().

I'll post something later on...

Kurt

On Thu, Apr 25, 2013 at 09:43:20AM +0200, Wolfgang Grandegger wrote:
> On 04/25/2013 09:24 AM, Kurt Van Dijck wrote:
> > On Thu, Apr 25, 2013 at 08:41:16AM +0200, Wolfgang Grandegger wrote:
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
> > would it make sense to maintain the split into enumif-test.c and enumif.c,
> > so for example Stephane could just link to libenumif.a?
> 
> Well, a better place might be libsocketcan then. In general it would be
> nice to host libsocketcan (maybe as liblinuxcan) at
> https://gitorious.org/linux-can as well.
> 
> Wolfgang.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
