From: Patrick Menschel <menschel.p@posteo.de>
Subject: Re: isotp in mainline?
Date: Fri, 12 Jun 2020 22:00:01 +0200
Message-ID: <01ce3f69-3bae-4369-3fda-92c016a71251@posteo.de>
References: <20200611154337.GA3166627@x1>
 <9d3bcfde-68f3-c9e0-4c63-cbae61915585@posteo.de>
 <20200612153641.GA3433528@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:52101 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFLUAF (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 12 Jun 2020 16:00:05 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 3D8812400FC
        for <linux-can@vger.kernel.org>; Fri, 12 Jun 2020 22:00:02 +0200 (CEST)
In-Reply-To: <20200612153641.GA3433528@x1>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Drew Fustini <drew@beagleboard.org>
Cc: linux-can@vger.kernel.org

> Maybe it was just to a test to see if the the protocol type existed?
> 
> It does look like the protocol is defined in include/uapi/linux/can.h:
> 
> #define CAN_ISOTP	6 /* ISO 15765-2 Transport Protocol */
> 
> However, there does not appear to be any implementation in the mainline
> kernel.
> 
> I recall Oliver mentioning that he should try to mainline isotp modules
> at the end of the J1939 talk at ELC-E last October [1]. I don't see any
> posts regarding isotp in the linux-can archives since then, so I thought
> I would bring it up.

Hi,

you're perfectly right. I just tested that script on a fresh ubuntu
20.04 install and it turns out, isotp-module is missing.

"OSError: [Errno 93] Protocol not supported"

I must have compiled it by hand back then.

--Patrick
