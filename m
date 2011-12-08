From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: CAN State Information
Date: Thu, 08 Dec 2011 20:15:00 +0100
Message-ID: <4EE10CB4.2090604@grandegger.com>
References: <166589D0B9DD2547A1319599B9BADA1FC1960C@vsv-exchange.ixxat.intranet.priv>
	<4EDE342E.8030102@grandegger.com>
	<166589D0B9DD2547A1319599B9BADA1FC1981F@vsv-exchange.ixxat.intranet.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <166589D0B9DD2547A1319599B9BADA1FC1981F-F+3lUZ2EnXJqWLKVXlbt41Kd6C4pVHazbKV4uwnAPJ4@public.gmane.org>
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
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

Hello James,

On 12/08/2011 09:43 AM, kime-Z4QKGCRq86k@public.gmane.org wrote:
> Hello,
> Thanks for the response.  I am using can_get_state() as part of my start_CAN routine.  After, I call can_do_start(), I read the state to see if I need to do bus-off recovery.  So it is not a frequent call.  I was able to see the states correctly on all four CAN channels with "ip -d -s link".  

OK, just to be sure. Does the "canconfig canX state" from the
Pengutronix canutils list the state correctly for any device?
I just tried here and it works fine.

> I updated the code in plx_pci.c to include support for the IXXAT card.  I wanted to ask you how to submit the changes since I have not done it before.  I attached a patch file.

Nice! A patch should be submitted as *inline* mail to the linux-can
*and* netdev mailing list with a proper subject, patch description and
signed-off-by line. The subject line should be something like:

"[PATCH net-next] can: plx_pci: add support for IXXAT PCI cards"

It's best to use git to create and send the patch but for simple patches
it doesn't really matter.

Wolfgang.
