From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH v3 0/4] Consolidate and unify state change handling
Date: Wed, 26 Nov 2014 11:22:20 +0000
Message-ID: <20141126112220.8026.88806@shannon>
References: <212bdd30-5398-4189-b928-5b9e674ebaa8@GRBSR0089.marel.net>
 <54723716.5000509@grandegger.com> <20141125155145.30778.82976@shannon>
 <5474EF7F.6060008@grandegger.com> <20141126101219.715.59065@shannon>
 <9f68402e21956c1c56c495f49bc693dd@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0056.outbound.protection.outlook.com ([157.56.112.56]:42700
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750864AbaKZLWZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Nov 2014 06:22:25 -0500
In-Reply-To: <9f68402e21956c1c56c495f49bc693dd@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de

Quoting Wolfgang Grandegger (2014-11-26 10:29:01)
> On Wed, 26 Nov 2014 10:12:19 +0000, Andri Yngvason
> <andri.yngvason@marel.com> wrote:
> > Quoting Wolfgang Grandegger (2014-11-25 21:07:11)
> >> On 11/25/2014 04:51 PM, Andri Yngvason wrote:
...
> >> > I need this because of missing interrupts from the controller and
> >> > failure to
> >> > address this in the driver. This could be fixed by always leaving the
> >> > bus error
> >> > interrupts on and polling the state on tx. I'm not sure if either of
> >> > those are a
> >> > good idea.
> >> 
> >> You should fix your Flexcan platform binding.
> >>
> > I'm not quite sure what that means. Should I add the tx-polling and
> leave
> > the
> > interrupts on, or do you think there might be something wrong with my
> > device
> > tree or architecture specific code?
> > 
> > The imx6 manual doesn't really say explicitly which "events" will
> trigger
> > interrupts; it only says which interrupts can be turned on/off. I'm
> > assuming
> > those are the available interrupts. State transition interrupts are not
> > among
> > them (except for "warning" which isn't really a state, and bus-off).
> 
> I'm referring to the "[TR]WRN_INT not connected" bug mentioned here:
> 
> http://lxr.free-electrons.com/source/drivers/net/can/flexcan.c#L162
> 
> If FLEXCAN_HAS_BROKEN_ERR_STATE is set, the bus error interrupt will not
> be disabled. But I'm somehow surprised that tat error shows up in an
> i.MX6.
> 
WRN_INT is only for the <96 to >=96 transition, so it doesn't really help.

--
Andri
