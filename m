From: John Whitmore <arigead@gmail.com>
Subject: Re: [PATCH] mcp251x: mcp2515 stops receiving
Date: Thu, 22 May 2014 11:28:44 +0100
Message-ID: <20140522102442.GB3826@griso.site>
References: <2E9F00CBB66AB544A1ACDC59627518BA0DC7ED11@mailserver>
 <5370FE36.8020901@pengutronix.de>
 <20140521235346.GA15375@griso.site>
 <2E9F00CBB66AB544A1ACDC59627518BA0DC96DCF@mailserver>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:44806 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbaEVK2S (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 May 2014 06:28:18 -0400
Received: by mail-wi0-f170.google.com with SMTP id bs8so9645805wib.5
        for <linux-can@vger.kernel.org>; Thu, 22 May 2014 03:28:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2E9F00CBB66AB544A1ACDC59627518BA0DC96DCF@mailserver>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Rost, Martin" <Martin.Rost@tonfunk.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Thu, May 22, 2014 at 06:38:18AM +0000, Rost, Martin wrote:
> 
> Hello John,
> 
> > -----Original Message-----
> > From: linux-can-owner@vger.kernel.org [mailto:linux-can-
> > owner@vger.kernel.org] On Behalf Of John Whitmore
> > Sent: Thursday, May 22, 2014 1:54 AM
> > To: Marc Kleine-Budde
> > Cc: Rost, Martin; linux-can@vger.kernel.org; Alexander Shiyan
> > Subject: Re: [PATCH] mcp251x: mcp2515 stops receiving
> > 
> > I'm not an expert in the Linux Driver code nor the implemented fix but I can
> > confirm that the Interrupt is generated with no flags set. I'm not sure of the
> > 10mS timing but I'd imagine that should work.
> > 
> 
> Thanks for confirming it.
> I fiddled a bit with the timing, and it seemed that 5ms would catch some but not all occurrences of this problem.
> So I went for 10 to make sure.
> 
> I'm not too deep into kernel internals, so is there some best practice to this?
>

I honestly can't answer about best practice on working around apparent flaws in
Hardware ;-) I'll leave somebody else to answer that one. 
 
> Regards,
> Martin


