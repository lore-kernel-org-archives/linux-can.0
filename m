From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: can-j1939 with Linux kernel >= 4.1.6
Date: Thu, 05 Nov 2015 23:36:10 +0100
Message-ID: <ABC86433-AFD3-4AE7-A505-B6EEDE4DBA8E@vandijck-laurijssen.be>
References: <zarafa.563a2456.4baa.66af665a07f4e8e3@euve35974.vserver.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:56445 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756358AbbKEWgQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Nov 2015 17:36:16 -0500
In-Reply-To: <zarafa.563a2456.4baa.66af665a07f4e8e3@euve35974.vserver.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: linux-can <linux-can@vger.kernel.org>



On 4 November 2015 16:29:26 CET, Michael Luxen <mluxen@gmx.net> wrote:
>Hello Kurt,
>
>I've a quick scan of the discussion about can-j1939 of the last
>days/weeks.
>
>I've in mind of the past (1,5 year ago) that can-j1939 was running with
>my BeagleBone Black based on kernel v3.8.
>Due to some updates on the BBB I'm using now more or less the latest
>kernel 4.1.6! Within the J1939 API discussion of the last days I've
>seen the recommendation that can-j1939 is stable on kernel 3.12!
>
>What is with kernel >4.x?
>Is can-j1939 usable in general on kernel >4.x? I like to get an updated
>impression of the socket can-j1939 functionality/implementation!
>

There have been internal changes in the generic networking stack that canj1939 need to adapt. I haven't done that yet.
It is possible, I'm sure.

Kurt

>
>Regards
>Michael

Sent from a small mobile device
