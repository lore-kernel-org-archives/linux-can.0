From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 16:47:37 +0100
Message-ID: <2683498.lh8gVOy8oT@ws-stein>
References: <20120321091055.GA433@vandijck-laurijssen.be> <1683048.Xku7xyE0R6@ws-stein> <4F69DCEF.20800@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:51049 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753015Ab2CUPrl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Mar 2012 11:47:41 -0400
In-Reply-To: <4F69DCEF.20800@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: dev@sebastianhaas.info, linux-can@vger.kernel.org

Am Mittwoch, 21. M=C3=A4rz 2012, 14:51:43 schrieb Marc Kleine-Budde:
> On 03/21/2012 02:29 PM, Alexander Stein wrote:
> >> Further, there are only certain dlc values allowed for CAN FD. We =
must
> >> decide if the enforce these values or simply do padding with "0"
> >> somewhere.>=20
> > What I understand from the proposal is that DLCs >8 are optional. S=
o you
> > might get hardware which still supports only 8 bytes. How can/shoul=
d
> > this be handled?
>=20
> I haven't read the pdf that Kurt linked in the original mail. Is the
> usage of dlc > 8 optional or the support of dlc > 8 in hardware?

Quoted from section 6:
> The CAN FD protocol allows frames with more than eight data bytes. It=
 is
> not required that all CAN FD implementations support longer frames, C=
AN
> FD implementations may be limited to a subset of DATA FIELD length. A=
 CAN FD
> implementation that supports only up to e.g. eight data bytes in a fr=
ame
> shall not treat longer received frames as an error, fault-free longer
> frames shall be acknowledged and shall take part in acceptance filter=
ing.
> Received data bytes that exceed the CAN FD=E2=80=99s data handling ca=
pacity shall
> be discarded. A such limited CAN FD implementation that is requested =
to
> transmit a longer frame shall fill up the data bytes in the frame tha=
t
> exceed the data handling capacity with a constant byte pattern. This
> pattern shall be chosen so that it does not cause the insertion of ST=
UFF
> BITS, e.g. 0xCC.

Sounds to me like hardware support of dlc > 8 is optional. Even in the =
fact=20
that you want the controller to send more than e.g. 8 bytes the control=
ler=20
shall insert stuff bits (0xCC) for unsupported data bytes.

Alexander
--=20
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
August-Bebel-Str. 29
D-07973 Greiz

Tel: +49-3661-6279-0, Fax: +49-3661-6279-99
eMail:    Alexander.Stein@systec-electronic.com
Internet: http://www.systec-electronic.com

Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Jena, HRB 205563
