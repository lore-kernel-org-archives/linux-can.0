From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: mailmap
Date: Thu, 6 Oct 2016 15:21:30 +0200
Message-ID: <20161006132130.GA4131@airbook.vandijck-laurijssen.be>
References: <20161006122427.GF26915@airbook.vandijck-laurijssen.be>
 <8c0ae82e-dd87-7b33-a8ea-c76db44e8491@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:48766 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbcJFNWb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 09:22:31 -0400
Content-Disposition: inline
In-Reply-To: <8c0ae82e-dd87-7b33-a8ea-c76db44e8491@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

> On 10/06/2016 02:24 PM, Kurt Van Dijck wrote:
> > Besides the legal aspect of squashing the whole j1939 tree, which I did
> > half on EIA, half in private time, it sure seems a good idea to fix
> > the email address in .mailmap:
> 
> I was hoping that .mailmap would replace the email address but it seems
> that it's really only used by shortlog.

git log --use-mailmap

Anyway, I'm probably not the first with this problem.
I appreciate the situation that commits in the past (I have a few
commits as kurt.van.dijck@eia.be) remain as is, and people and tools are
able to map this to my new situation.

Kind regards,
Kurt
