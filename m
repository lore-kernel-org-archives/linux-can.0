From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 14:34:48 +0100
Message-ID: <20120321133448.GA6428@vandijck-laurijssen.be>
References: <20120321091055.GA433@vandijck-laurijssen.be>
 <20120321120846.GB3372@vandijck-laurijssen.be>
 <4F69CA74.3020607@pengutronix.de>
 <1683048.Xku7xyE0R6@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:54388 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246Ab2CUNey convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Mar 2012 09:34:54 -0400
Content-Disposition: inline
In-Reply-To: <1683048.Xku7xyE0R6@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, dev@sebastianhaas.info, linux-can@vger.kernel.org

On Wed, Mar 21, 2012 at 02:29:05PM +0100, Alexander Stein wrote:
> Am Mittwoch, 21. M=C3=A4rz 2012, 13:32:52 schrieb Marc Kleine-Budde:
> > On 03/21/2012 01:08 PM, Kurt Van Dijck wrote:
> >=20
> > Further, there are only certain dlc values allowed for CAN FD. We m=
ust
> > decide if the enforce these values or simply do padding with "0" so=
mewhere.
>=20
> What I understand from the proposal is that DLCs >8 are optional. So =
you might=20
> get hardware which still supports only 8 bytes. How can/should this b=
e=20
> handled?

I assume that if the hardware does not support a thing, things get comp=
licated
anyway.
But there is no hardware yet :-)

Kurt
