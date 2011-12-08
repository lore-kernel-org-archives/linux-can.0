From: <kime-Z4QKGCRq86k@public.gmane.org>
Subject: RE: CAN State Information
Date: Thu, 8 Dec 2011 09:43:23 +0100
Message-ID: <166589D0B9DD2547A1319599B9BADA1FC1981F@vsv-exchange.ixxat.intranet.priv>
References: <166589D0B9DD2547A1319599B9BADA1FC1960C@vsv-exchange.ixxat.intranet.priv>
	<4EDE342E.8030102@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CCB585.723CC284"
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <4EDE342E.8030102-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-core>
List-Post: <mailto:socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01CCB585.723CC284
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,
Thanks for the response.  I am using can_get_state() as part of my =
start_CAN routine.  After, I call can_do_start(), I read the state to =
see if I need to do bus-off recovery.  So it is not a frequent call.  I =
was able to see the states correctly on all four CAN channels with "ip =
-d -s link". =20

I updated the code in plx_pci.c to include support for the IXXAT card.  =
I wanted to ask you how to submit the changes since I have not done it =
before.  I attached a patch file.


Mit freundlichen Gr=FCssen / Yours sincerely,

James Kime
Entwicklung / Development
--------------------------------------------
IXXAT Automation GmbH
Leibnizstr. 15, 88250 Weingarten, Germany
Phone +49-751-56146-181
Fax   +49-751-56146-29
mailto:kime-Z4QKGCRq86k@public.gmane.org
http://www.ixxat.de
--------------------------------------------
PRIVILEGED AND CONFIDENTIAL.
Any unauthorized use or disclosure
is strictly prohibited.
--------------------------------------------
Sitz der Gesellschaft: Weingarten
Handelsregister Ulm HRB 551905
Gesch=E4ftsf=FChrer:
Dipl.-Ing. Christian Schlegel
--------------------------------------------

-----Original Message-----
From: Wolfgang Grandegger [mailto:wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org]=20
Sent: Tuesday, December 06, 2011 4:27 PM
To: Kime, James
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org; linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: CAN State Information

Hello,

On 12/06/2011 02:56 PM, kime-Z4QKGCRq86k@public.gmane.org wrote:
> Hello,
>=20
> I am using socketcan with a combination of 3 passive plx cards (1 dual =
channel and 2 single channel) on kernel 3.0.0-13.  I have the =
libsocketcan-0.0.8 installed as well. I can use all 4 CAN channels but =
for some reason I can only use can_get_state() with the two single cards =
and the dual card returns -1 for both channels.  I have attempted =
another setup this time with just the two single cards and when I use =
the can_get_state() I am able to only return the state on 1 of them. =
Then I attempted putting in the dual card alone and the same result, one =
channel works the other does not.=20

Hm, if "ip -d -s link" lists the state correctly, then it's most likely
a problem with libsocketcan. Anyway, for what purpose would you like to
use can_get_state()? It's not forseen for frequent polling of the CAN
error state. Please use error messages instead.

> I would appreciate any advice, this seems like a strange problem to =
me.=20

What Socket-CAN driver are you using for the IXXAT cards? There is still
no support in mainline Linux, IIRC. Maybe there is some mismatch with
the header files.

Hope it helps.

Wolfgang.

PS: I added our new mailing list linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org to the CC.
    BerliOS will be closed end of the year.


> Mit freundlichen Gr=FCssen / Yours sincerely,
>=20
> James Kime
> Entwicklung / Development
> --------------------------------------------
> IXXAT Automation GmbH
> Leibnizstr. 15, 88250 Weingarten, Germany
> Phone +49-751-56146-181
> Fax   +49-751-56146-29
> mailto:kime-Z4QKGCRq86k@public.gmane.org
> http://www.ixxat.de
> --------------------------------------------
> PRIVILEGED AND CONFIDENTIAL.
> Any unauthorized use or disclosure
> is strictly prohibited.

Please drop these lines when you send to a public mailing list.

------_=_NextPart_001_01CCB585.723CC284
Content-Type: application/octet-stream;
	name="plx_pci_patch"
Content-Transfer-Encoding: base64
Content-Description: plx_pci_patch
Content-Disposition: attachment;
	filename="plx_pci_patch"

ZGlmZiAtTmF1ciBvbGQvcGx4X3BjaS5jIG5ldy9wbHhfcGNpLmMKLS0tIG9sZC9wbHhfcGNpLmMJ
MjAxMS0wNy0yMiAwNDoxNzoyMy4wMDAwMDAwMDAgKzAyMDAKKysrIG5ldy9wbHhfcGNpLmMJMjAx
MS0xMi0wOCAwOTozMjozOS42OTY3NzQ1MDIgKzAxMDAKQEAgLTQzLDcgKzQzLDggQEAKIAkJCSJU
RVdTIFRFQ0hOT0xPR0lFUyBUUE1DODEwLCAiCiAJCQkiZXNkIENBTi1QQ0kvQ1BDSS9QQ0kxMDQv
MjAwLCAiCiAJCQkiZXNkIENBTi1QQ0kvUE1DLzI2NiwgIgotCQkJImVzZCBDQU4tUENJZS8yMDAw
IikKKwkJCSJlc2QgQ0FOLVBDSWUvMjAwMCwgIgorCQkJIklYWEFUIFBDLUkgMDQvUENJIikKIE1P
RFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsKIAogI2RlZmluZSBQTFhfUENJX01BWF9DSEFOIDIKQEAg
LTEyMSw2ICsxMjIsMTAgQEAKICNkZWZpbmUgRVNEX1BDSV9TVUJfU1lTX0lEX1BDSUUyMDAwCTB4
MDIwMAogI2RlZmluZSBFU0RfUENJX1NVQl9TWVNfSURfUENJMTA0MjAwCTB4MDUwMQogCisjZGVm
aW5lIElYWEFUX1BDSV9WRU5ET1JfSUQJCTB4MTBiNQorI2RlZmluZSBJWFhBVF9QQ0lfREVWSUNF
X0lECQkweDkwNTAKKyNkZWZpbmUgSVhYQVRfUENJX1NVQl9TWVNfSUQJCTB4MjU0MAorCiAjZGVm
aW5lIE1BUkFUSE9OX1BDSV9ERVZJQ0VfSUQJCTB4MjcxNQogCiAjZGVmaW5lIFRFV1NfUENJX1ZF
TkRPUl9JRAkJMHgxNDk4CkBAIC0xOTMsNiArMTk4LDE0IEBACiAJLyogYmFzZWQgb24gUEVYODMx
MSAqLwogfTsKIAorc3RhdGljIHN0cnVjdCBwbHhfcGNpX2NhcmRfaW5mbyBwbHhfcGNpX2NhcmRf
aW5mb19peHhhdCBfX2RldmluaXRkYXRhID0geworCSJJWFhBVCBQQy1JIDA0L1BDSSIsIDIsCisJ
UExYX1BDSV9DQU5fQ0xPQ0ssIFBMWF9QQ0lfT0NSLCBQTFhfUENJX0NEUiwKKwl7MCwgMHgwMCwg
MHgwMH0sIHsgezIsIDB4MDAsIDB4ODB9LCB7MiwgMHgyMDAsIDB4ODB9IH0sCisJJnBseF9wY2lf
cmVzZXRfY29tbW9uCisJLyogYmFzZWQgb24gUExYOTA1MCAqLworfTsKKwogc3RhdGljIHN0cnVj
dCBwbHhfcGNpX2NhcmRfaW5mbyBwbHhfcGNpX2NhcmRfaW5mb19tYXJhdGhvbiBfX2RldmluaXRk
YXRhID0gewogCSJNYXJhdGhvbiBDQU4tYnVzLVBDSSIsIDIsCiAJUExYX1BDSV9DQU5fQ0xPQ0ss
IFBMWF9QQ0lfT0NSLCBQTFhfUENJX0NEUiwKQEAgLTI2Nyw2ICsyODAsMTMgQEAKIAkJKGtlcm5l
bF91bG9uZ190KSZwbHhfcGNpX2NhcmRfaW5mb19lc2QyMDAwCiAJfSwKIAl7CisJCS8qIElYWEFU
IFBDLUkgMDQvUENJIGNhcmQgKi8KKwkJSVhYQVRfUENJX1ZFTkRPUl9JRCwgSVhYQVRfUENJX0RF
VklDRV9JRCwKKwkJUENJX0FOWV9JRCwgSVhYQVRfUENJX1NVQl9TWVNfSUQsCisJCTAsIDAsCisJ
CShrZXJuZWxfdWxvbmdfdCkmcGx4X3BjaV9jYXJkX2luZm9faXh4YXQKKwl9LAorCXsKIAkJLyog
TWFyYXRob24gQ0FOLWJ1cy1QQ0kgY2FyZCAqLwogCQlQQ0lfVkVORE9SX0lEX1BMWCwgTUFSQVRI
T05fUENJX0RFVklDRV9JRCwKIAkJUENJX0FOWV9JRCwgUENJX0FOWV9JRCwKCg==

------_=_NextPart_001_01CCB585.723CC284
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Socketcan-core mailing list
Socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
https://lists.berlios.de/mailman/listinfo/socketcan-core

------_=_NextPart_001_01CCB585.723CC284--
