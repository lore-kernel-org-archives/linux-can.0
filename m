From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: FlexCAN on imx28
Date: Mon, 6 Mar 2017 10:17:38 +1100
Message-ID: <9b6ca5ae-bad4-cb31-f325-694c14ca9463@optusnet.com.au>
References: <1488465746.18098.13.camel@serenergy.com>
 <31bc327a-a900-c5fa-67fc-08a93134e753@pengutronix.de>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:38906 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752582AbdCFCmh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 5 Mar 2017 21:42:37 -0500
In-Reply-To: <31bc327a-a900-c5fa-67fc-08a93134e753@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Steffen Malmgaard Mortensen <smm@serenergy.com>
Cc: linux-can <linux-can@vger.kernel.org>

On 03/03/17 22:23, Marc Kleine-Budde wrote:
> Hallo Steffen,
>
> I'm adding the linux-can ML on Cc, as the answer is of potential common
> interest.
>
> On 03/02/2017 03:42 PM, Steffen Malmgaard Mortensen wrote:
>> I have been experiencing problems with CAN package loss under high bus
>> load at high bit rates using an imx28.

Steffen didn't say which version of Linux he's using.

If he's using the latest NXP-supported version of Linux (2.6.35) then the 
following patches may be of interest to him.

Search for my posts on this thread and then follow the links to the other bug 
reports.

https://community.nxp.com/message/593611#comment-585209

This summarises the close to 20 separate bugs in the one old driver:

https://community.nxp.com/message/593606#593606

Why would anyone be using as old as 2.6.35? It is the only "supported" version 
for this chip i.MX53. And in my case the only one that can access the graphics 
hardware in the i.MX53.

If Stefan's Linux is a later version where the CAN driver uses the FlexCAN 
FIFO, but is the one using NAPI for everything, then that pretty much 
guarantees packet loss and overflow. The have been some very good recent 
changes to the driver to fix this.

Tom

