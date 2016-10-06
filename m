From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939
Date: Thu, 6 Oct 2016 10:44:07 +0200
Message-ID: <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:51194 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942134AbcJFIpI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 04:45:08 -0400
Content-Disposition: inline
In-Reply-To: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>

Hey Marc,

I was able to take a close look in the code.

> Hello,
> 
> I've ported Kurt's latest j1939 patches to linux-4.7. I've squashed all
> patches into one. Then a patch to undo unused modifications and a bunch
> of patches to make checkpatch happy.
> 
> I've pushed the result to
> 
> https://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can-next.git/log/?h=j1939
> 
> The remaining warning is about a case statement without fall through
> annotations and/or breaks:
> 
I rebased this code for my own use so that I have access to my
individual commits. You will find this on

git://github.com/kurt-vd/linux, branch j1939d-v4.7

I pushed 2 extra commits:
* 3dfa139: Pad TP data packets only
  This is based on the discussions here. I promised to move the
  padding...
* e2447ef: make TP data transmission work again
  This commit fixes a mistake you've done with the fall-trough
  statements in j1939tp_txnext (this isn't the easiest state machien on
  Earth :-) ).

Kind regards,
Kurt
