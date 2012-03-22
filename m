From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Thu, 22 Mar 2012 11:13:11 +0100
Message-ID: <20120322101311.GD426@vandijck-laurijssen.be>
References: <20120321110502.GA3372@vandijck-laurijssen.be>
 <4F69BEE3.2040705@pengutronix.de>
 <20120321120846.GB3372@vandijck-laurijssen.be>
 <4F69CA74.3020607@pengutronix.de>
 <4F69D5D2.5080003@hartkopp.net>
 <20120321135339.GB6428@vandijck-laurijssen.be>
 <4F69EC19.7090205@grandegger.com>
 <4F69EE38.9000904@hartkopp.net>
 <20120322092456.GB426@vandijck-laurijssen.be>
 <4F6AF320.7080605@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:24636 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920Ab2CVKNO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Mar 2012 06:13:14 -0400
Content-Disposition: inline
In-Reply-To: <4F6AF320.7080605@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, dev@sebastianhaas.info, linux-can@vger.kernel.org

On Thu, Mar 22, 2012 at 10:38:40AM +0100, Wolfgang Grandegger wrote:
> On 03/22/2012 10:24 AM, Kurt Van Dijck wrote:
> > On Wed, Mar 21, 2012 at 04:05:28PM +0100, Oliver Hartkopp wrote:
> >> On 21.03.2012 15:56, Wolfgang Grandegger wrote:
> >>
> 
> >>>>> 3. Will these differences be visible in the CAN registers? Is this relevant?
> >>>> Without hardware, it's a bit early to predict. I guess it will be visible, but
> >>>> not relevant since that's driver stuff.
> >>>
> >>> As CANFD controllers also supports CAN2.0 frames, they must provide the
> >>> the relevant information somehow, similar to EFF and SFF.
> > I doubt this.
> > EFF & SFF share the same bus. CANFD vs. CAN2.0 is not a per-frame thing. You
> > have configured it yourself at chip initialization time...
> 
> Why not? A CANFD capable controller should be able to distinguish
> between a legacy and a CANFD frame by looking to the BRS bit in the frame.
Good point!
Yet, it remains a bus property, not a per-frame property.
From the point that you know that CANFD frames are allowed,
putting single CAN2.0 frames on the bus looks useless.

Regards,
Kurt
