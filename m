From: Brandon Martin <martinbv@mothictech.com>
Subject: Re: [PATCH] Add TX limit for SocketCAN.
Date: Fri, 01 Sep 2017 09:54:53 -0400
Message-ID: <59A966AD.3030002@mothictech.com>
References: <1504232079-2583-1-git-send-email-zhongjie.shi@intel.com> <CANGgnMb5-cKT=PjxEF6yYAcUkcP29BRnHU+_xY3ASsT-GQ6qzQ@mail.gmail.com> <106C4230743D00439F3B474E2F2FC8CD53885BF7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxord1.mothictech.com ([99.198.117.115]:48414 "EHLO
        mxord1.mothictech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbdIAOEZ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Sep 2017 10:04:25 -0400
In-Reply-To: <106C4230743D00439F3B474E2F2FC8CD53885BF7@SHSMSX101.ccr.corp.intel.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Shi, Zhongjie" <zhongjie.shi@intel.com>, Austin Schuh <austin@peloton-tech.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can <linux-can@vger.kernel.org>

On 08/31/2017 11:22 PM, Shi, Zhongjie wrote:
> It will be also appreciated if you or Oliver can share with me the details of how to "use queuing discipline" to achieve this.

Presumably it works (or is supposed to work) just like any other 
socket/packet interface.  The "tc" userspace command (friend of 
iproute2) would configure it.  Whether this is actually functional at 
this time is not something I can speak to.
-- 
Brandon Martin
Mothic Technologies
317-565-1357 x7000
