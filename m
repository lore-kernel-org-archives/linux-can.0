From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: ip -details link fails
Date: Thu, 28 May 2015 10:46:09 +1000
Message-ID: <55666551.1040102@optusnet.com.au>
References: <BAY176-W131B8CC6A9756B64828C77D3CB0@phx.gbl>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:33616 "EHLO
	mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750812AbbE1AqN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 May 2015 20:46:13 -0400
In-Reply-To: <BAY176-W131B8CC6A9756B64828C77D3CB0@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 28/05/15 02:38, Ssagarr Patil wrote:
> Hi,
>
> I am currently using the following version of can driver
> # cat /proc/net/can/version
> rev 20120528 abi 9
>
> But when I do the following it fails,
>
> # ip -details link show can0
> RTNETLINK answers: Invalid argument
> Cannot send link get request: Invalid argument

There's also "canutils" and "can-utils" (they're different). We use one of 
these to configure our CAN ports. If you want to stick with Busybox then one 
of these may be your best option.

Best detailed here:

http://thread.gmane.org/gmane.linux.can/7164/focus=7221

From:

 > https://gitorious.org/linux-can/can-utils/
 > http://www.pengutronix.de/software/socket-can/download/canutils/v4.0/

Tom

