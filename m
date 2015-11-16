From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939 (Higher Layer Protocols)
Date: Mon, 16 Nov 2015 14:14:19 +0100
Message-ID: <20151116131419.GB28081@airbook.eia.lan>
References: <20151105180831.GA24951@bamboo.electronicsoup>
 <563BAC5A.8060604@posteo.de>
 <20151109194823.GA6539@bamboo.electronicsoup>
 <20151110105257.GA10664@airbook.eia.lan>
 <20151115215919.GA8018@BSA-cub>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:29600 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbbKPNPq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Nov 2015 08:15:46 -0500
Content-Disposition: inline
In-Reply-To: <20151115215919.GA8018@BSA-cub>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Whitmore <arigead@gmail.com>
Cc: "Menschel.P" <menschel.p@posteo.de>, linux-can@vger.kernel.org


[...]
> > 
> > > 
> > > Maybe I could jsut Linux J1939 but that might depend on subtle differences in
> > > Transport protocol.
> > 
> > 
> > Which subtle differences you refer to?
> > I read SAE-J1939 and ISO11783, and I found no differences.
> > Can you give an example?
> > 
> > Kurt
> 
> Sorry for the delay in responding been distracted. I've never read SAE-J1939
> but only ISO11783 I should have made it clearer when I said "might". I 
> was meaning that there might be differences between the two I don't know.
> 
> I sort of assumed when they took SAE-J1939 to create ISO11783 that they had a
> good reason (Apart from selling another standard) for creating a new standard.

They have very different application layers.
That does however not justify re-defining the transport layers, indeed.

Kurt


> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
