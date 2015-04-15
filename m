From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: =?UTF-8?Q?Re:_Hilfe_-_Wohin_Anfragen_bez=c3=bcgl._SocketCAN?=
 =?UTF-8?Q?/FlexCAN?=
Date: Wed, 15 Apr 2015 14:23:03 +0200
Message-ID: <552E5827.6010304@pengutronix.de>
References: <552E55ED.7080904@synergetik.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="51B1av57iscwkgixFUKLwuiljSx9jRLhl"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38260 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbbDOMXL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Apr 2015 08:23:11 -0400
In-Reply-To: <552E55ED.7080904@synergetik.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Markus Uhle <markus.uhle@synergetik.de>, oliver.hartkopp@volkswagen.de, socketcan-users@lists.berlios.de, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "sales@pengutronix.de" <sales@pengutronix.de>Oliver Hartkopp <oliver.hartkopp@volkswagen.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--51B1av57iscwkgixFUKLwuiljSx9jRLhl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/15/2015 02:13 PM, Markus Uhle wrote:
> wir benutzen in einem Medizinger=C3=A4t SocketCAN in Verbindung mit Fle=
xCAN=20
> (i.MX53 Prozessor).
> Ich habe im Broadcastmode (SocketCAN, BCM-Manager) einige Probleme, die=
=20
> ich gerne schildern w=C3=BCrde.
>=20
> Gibt es noch eine aktive Mailing-List f=C3=BCr SocketCAN und FlexCAN ?
> An wen k=C3=B6nnte ich mich hier wenden?

Ja und zwar die englischsprachigen Liste linux-can@vger.kernel.org

> Mein Problem:
> - Ich registriere im Broadcastmanager z.B. 20 RTR-Requests, die alle=20
> 100ms zyklisch gesendet werden sollen (in einer Funktion, also in Etwa =

> zur gleichen Zeit)
> - Am CAN-Bus h=C3=A4ngt nur noch die Busterminierung und ein CAN-Sniffe=
r=20
> (PeakCAN), der die Messages ack'ed.
> - Wenn ich mehr als 12 Messages im BCM registiere, werden alle Messages=
=20
> ab der 13. Message nur noch selten (ca. alle 1-10 Sekunden) gesendet

Ich habe noch nie mit dem Broadcastmanager gearbeitet....

> Ich habe die Linux-Sourcen vom BCM und vom FlexCAN schon angeschaut und=
=20
> finde keine offensichtlichen Fehler.
>=20
> Meine Vermutung ist, dass wenn ich sehr schnell hintereinander im BCM=20
> (SocketCAN) Nachrichten registiere, die zyklisch alle
> 100ms gesendet werden sollen, dann liegen diese so dicht zusammen, dass=
=20
> die n=C3=A4chste Nachricht eventuell schon gesendet
> wird (vom BCM zum FlexCAN), bevor die alte Nachricht =C3=BCber den Bus =
raus=20
> ist. In dem Fall wird die alte Nachricht eventuell
> abgebrochen. Ich habe im FlexCAN-Treiber keinen R=C3=BCckgabewert wie "=
cannot=20
> be sent, because I am busy" gefunden.

Das ist richtig, diesen R=C3=BCckgabewert gibt es nicht, da der Treiber s=
eine
TX-Queue anh=C3=A4lt, falls er keine Pakete mehr aufnehmen kann. Zur Zeit=
 ist
im Flexcan Treiber nur eine Queue mit der Tiefe von einem Paket
implementiert. Die L=C3=A4nge der Queue ist per default 10 Pakete. Das k=C3=
=B6nnte
Ihre Beobachtung erkl=C3=A4ren. Vielleicht ist der BCM nicht darauf
ausgelegt, dass nicht alle Pakete in der Queue laden.

Ich schlage vor, dass Sie Ihre Problembeschreibung auf die Liste posten
und wir dort weiter diskutieren.

Gr=C3=BC=C3=9Fe,
Marc Kleine-Budde

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--51B1av57iscwkgixFUKLwuiljSx9jRLhl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJVLlgnAAoJECte4hHFiupUdi8QAJ9D73X9Mva3ARAKc+GSfn/7
D0XcDD8aQjSut7Ri1Hxfjk0L4LtEFX8mmGw4sepcRPq51pDzyFTKPBbHCWF7Mu0D
IhlnrKiS9WKjVb6DuNK6ygNKKAC9pCCAR4ogzfKAysGqDTIkPX0eDw7+azls83KC
hEh2U1wYY5lveUzndZvkTGGdiOHPWvAqESt8MwA8b8+5D05PpdG0orP1vSnF1eRS
4We8ShuCeFonrf1LJzB83RSS4vPDRjgXFYB+Tj8TDDZIwfBzgEBerVMVWMibVB4I
2BGJHAKiNa8t6y2eS1nsKtai+tMsopAXY95WSW3oZ8a85m9GbIATj6DRxCdiXASQ
EuEm8OuNavqJAhi18Lyb/03CYHoa6KImcPinwzsSk8bN58IcrTJ2tqfN87DUSECq
x9TCq1hERrTng0Q8sV9U26p1XWmgb6DvNmpg4+itUgZytslGfCRD7hRPQqrWd3p/
tDBVndCdciA6XqKFsjNHgp88EuCf7rq+3hkI05pAq0oVU5EKXnkQF+ajQdksItDQ
dnVDUfQ1V/gZMP3ay8nIXTPvQ8XhBYdpDcGeLeOPgLQOcIuOwOCKYEbPzv8Im+Dw
erVkmhhyy+r3GuGeexQCXsD+UTcwRuCf4TqOsZ63XljvBps8Sx58+uNey5g40CRU
j1HrgXh7g4bmOpGCQUxY
=Qv2Y
-----END PGP SIGNATURE-----

--51B1av57iscwkgixFUKLwuiljSx9jRLhl--
