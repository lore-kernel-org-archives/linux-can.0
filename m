From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 Linux
Date: Thu, 14 Apr 2016 14:22:40 +0200
Message-ID: <20160414122240.GB7409@airbook.vandijck-laurijssen.be>
References: <4E8D1C61-042C-4AF2-99AF-410CEEBA6861@vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA87095C7B@POCITMSEXMB05.LntUniverse.com>
 <20160409114019.GA8567@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709986A@POCITMSEXMB05.LntUniverse.com>
 <20160412082020.GA19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709A50F@POCITMSEXMB05.LntUniverse.com>
 <20160412181540.GE19875@airbook.vandijck-laurijssen.be>
 <03B271BE48E2554EB34508DAB79DBABA8709B02E@POCITMSEXMB05.LntUniverse.com>
 <20160414100314.GB16018@airbook.vandijck-laurijssen.be>
 <570F75D7.6000708@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:60594 "EHLO
	relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059AbcDNMZi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Apr 2016 08:25:38 -0400
Content-Disposition: inline
In-Reply-To: <570F75D7.6000708@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dinesh Velayudham <Dinesh.Velayutham@LnTtechservices.com>, gianluca <gianlucarenzi@eurek.it>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> On 04/14/2016 12:03 PM, Kurt Van Dijck wrote:
> > I pushed j1939d-v3.19.
> > 
> > I created the branch by merging & cherry-pick, as suggested earlier.
> > I didn't have compile problems.
> > 
> > I have not tested it, yet I foresee no problems, or at least no
> > differences compared to my other j1939d-vx.xx branches.
> 
> I want to do the first steps of mainlining j1939. Which is the preferred
> branch? I've started with j1939/j1939d-v4.3.

I'm not sure if mainlining introduces a big squash, or a regular merge.
I'd say that j1939d-v4.1 show a cleaner history.
The only reason for existence of j1939-v4.3 is that I was working with a
v4.3 at that point.

Kurt
