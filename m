From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: CAN State Information
Date: Tue, 06 Dec 2011 16:26:38 +0100
Message-ID: <4EDE342E.8030102@grandegger.com>
References: <166589D0B9DD2547A1319599B9BADA1FC1960C@vsv-exchange.ixxat.intranet.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <166589D0B9DD2547A1319599B9BADA1FC1960C-F+3lUZ2EnXJqWLKVXlbt41Kd6C4pVHazbKV4uwnAPJ4@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-core>
List-Post: <mailto:socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: kime-Z4QKGCRq86k@public.gmane.org
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hello,

On 12/06/2011 02:56 PM, kime-Z4QKGCRq86k@public.gmane.org wrote:
> Hello,
> =

> I am using socketcan with a combination of 3 passive plx cards (1 dual ch=
annel and 2 single channel) on kernel 3.0.0-13.  I have the libsocketcan-0.=
0.8 installed as well. I can use all 4 CAN channels but for some reason I c=
an only use can_get_state() with the two single cards and the dual card ret=
urns -1 for both channels.  I have attempted another setup this time with j=
ust the two single cards and when I use the can_get_state() I am able to on=
ly return the state on 1 of them. Then I attempted putting in the dual card=
 alone and the same result, one channel works the other does not. =


Hm, if "ip -d -s link" lists the state correctly, then it's most likely
a problem with libsocketcan. Anyway, for what purpose would you like to
use can_get_state()? It's not forseen for frequent polling of the CAN
error state. Please use error messages instead.

> I would appreciate any advice, this seems like a strange problem to me. =


What Socket-CAN driver are you using for the IXXAT cards? There is still
no support in mainline Linux, IIRC. Maybe there is some mismatch with
the header files.

Hope it helps.

Wolfgang.

PS: I added our new mailing list linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org to the CC.
    BerliOS will be closed end of the year.


> Mit freundlichen Gr=FCssen / Yours sincerely,
> =

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
