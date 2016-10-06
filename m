From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939
Date: Thu, 6 Oct 2016 11:24:03 +0200
Message-ID: <20161006092403.GA26915@airbook.vandijck-laurijssen.be>
References: <a6ad3606-b295-dc72-c557-098c45769cb9@pengutronix.de>
 <20161006084407.GB11907@airbook.vandijck-laurijssen.be>
 <a6920929-30e0-0c69-52f1-96998698bbf6@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:58344 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965585AbcJFJZE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 05:25:04 -0400
Content-Disposition: inline
In-Reply-To: <a6920929-30e0-0c69-52f1-96998698bbf6@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Kurt Van Dijck <kurt.van.dijck@eia.be>

> 
> On 10/06/2016 10:44 AM, Kurt Van Dijck wrote:
> >> The remaining warning is about a case statement without fall through
> >> annotations and/or breaks:
> >>
> > I rebased this code for my own use so that I have access to my
> > individual commits. You will find this on
> > 
> > git://github.com/kurt-vd/linux, branch j1939d-v4.7
> 
> As long as the diff between you and my branch is zero :)

That is the case.

> 
> > I pushed 2 extra commits:
> > * 3dfa139: Pad TP data packets only
> >   This is based on the discussions here. I promised to move the
> >   padding...
> 
> Thanks.
> 
> > * e2447ef: make TP data transmission work again
> >   This commit fixes a mistake you've done with the fall-trough
> >   statements in j1939tp_txnext (this isn't the easiest state machien on
> >   Earth :-) ).
> 
> Thanks.
> 
> I have cherry picked both and will push them to v4.7. If everything
> works on the v4.7 branch, I'll squash most of it together an move to v4.8.
> 
> Thoughts?

1) I'll try to move module parameters to /proc/sys/net/can-j1939/ items.
2) Tonight, I happen to meet an "open source license" expert.
   I'll try to discuss with him the email address thing.

Kurt
