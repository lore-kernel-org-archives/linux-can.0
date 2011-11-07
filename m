From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: git repos @ gitorious.org
Date: Mon, 07 Nov 2011 09:54:33 +0100
Message-ID: <4EB79CC9.7000901@pengutronix.de>
References: <4EB1A448.6000703@hartkopp.net> <4EB1C132.2070103@pengutronix.de> <20111103130841.GG317@e-circ.dyndns.org> <20111104161655.GC18026@e-circ.dyndns.org> <4EB69430.7070801@pengutronix.de> <20111107080712.GA279@e-circ.dyndns.org> <4EB79288.5010409@pengutronix.de> <20111107083222.GB279@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig959E74FF6BCD24B22C1E6BFD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60485 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab1KGIyi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Nov 2011 03:54:38 -0500
In-Reply-To: <20111107083222.GB279@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>, socketcan-core@lists.berlios.de

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig959E74FF6BCD24B22C1E6BFD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/07/2011 09:32 AM, Kurt Van Dijck wrote:
> On Mon, Nov 07, 2011 at 09:10:48AM +0100, Marc Kleine-Budde wrote:
>> On 11/07/2011 09:07 AM, Kurt Van Dijck wrote:
>>> On Sun, Nov 06, 2011 at 03:05:36PM +0100, Marc Kleine-Budde wrote:
>>>> On 11/04/2011 05:16 PM, Kurt Van Dijck wrote:
>>>>> On Thu, Nov 03, 2011 at 02:08:41PM +0100, Kurt Van Dijck wrote:
>>>>>> On Wed, Nov 02, 2011 at 11:16:18PM +0100, Marc Kleine-Budde wrote:=

>>>>>>> On 11/02/2011 09:12 PM, Oliver Hartkopp wrote:
>>>>>>>>
>>>>>>>> https://gitorious.org/~<kurts_account>/linux-can/can-modules-j19=
39
>>>>>>>> https://gitorious.org/~<kurts_account>/linux-can/can-utils-j1939=

>>>>>
>>>>> Since the can-j1939-modules require one to use a modified iproute2,=

>>>>> I wanted to create an iproute-j1939 within linux-can, but I see no =
way
>>>>> to accomplish this.
>>>>>
>>>>> Any opinions on how to proceed?
>>>>
>>>> Google for the iproute2 git upstream, clone it, modify it. Create a
>>>> iproute2 git repo on gitorious, push your changes there.
>>>
>>> I see not how to create on Gitorious a linux-can/iproute2-can-j1939
>>> or similar. It looks to me as if I need to create a project first.
>>
>> I think via:
>>
>> https://gitorious.org/projects/new
> The website then shows:
> " After you have created the project you will have the option
> of adding one or more repositories to the project."
>=20
> My intention was to add a iproute2-j1939 repository under the project
> linux-can. Since I have a
> https://gitorious.org/~kurt-vd/linux-can/can-j1939-modules
> I think no-one would find a
> https://gitorious.org/~kurt-vd/linux-j1939/iproute2-can-j1939
> since both repositories belong to a different project.
>=20
> Or is my last assumption wrong?

makes sense. let's see what I can do -
gitorious is quite web2.0isch to me :)

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig959E74FF6BCD24B22C1E6BFD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk63nMwACgkQjTAFq1RaXHNFWQCeL1JEmlwXJCapYz0TyZyNtfdV
MyEAnizKzaYNG7qvpzPPfBLOFQ8q/J4x
=AxNw
-----END PGP SIGNATURE-----

--------------enig959E74FF6BCD24B22C1E6BFD--
