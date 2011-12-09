From: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Subject: Re: CAN State Information
Date: Fri, 09 Dec 2011 10:00:27 +0100
Message-ID: <4EE1CE2B.6090909@grandegger.com>
References: <166589D0B9DD2547A1319599B9BADA1FC1960C@vsv-exchange.ixxat.intranet.priv>
	<4EDE342E.8030102@grandegger.com>
	<166589D0B9DD2547A1319599B9BADA1FC1981F@vsv-exchange.ixxat.intranet.priv>
	<4EE10CB4.2090604@grandegger.com>
	<166589D0B9DD2547A1319599B9BADA1FC19968@vsv-exchange.ixxat.intranet.priv>
	<4EE1C3BF.70104@grandegger.com> <4EE1C47A.7080507@grandegger.com>
	<166589D0B9DD2547A1319599B9BADA1FC1998A@vsv-exchange.ixxat.intranet.priv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <166589D0B9DD2547A1319599B9BADA1FC1998A-F+3lUZ2EnXJqWLKVXlbt41Kd6C4pVHazbKV4uwnAPJ4@public.gmane.org>
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

On 12/09/2011 09:45 AM, kime-Z4QKGCRq86k@public.gmane.org wrote:
> I am new to using trace, but I think this is the output you are looking for: 
> 
...
>        canconfig-3288  [000]  3756.163033: can_fill_xstats <-rtnl_link_fill
>        canconfig-3288  [000]  3756.163034: can_fill_info <-rtnl_link_fill
>        canconfig-3288  [000]  3756.163041: can_fill_xstats <-rtnl_link_fill
>        canconfig-3288  [000]  3756.163042: can_fill_info <-rtnl_link_fill
>        canconfig-3288  [000]  3756.163047: can_fill_xstats <-rtnl_link_fill
>        canconfig-3288  [000]  3756.163048: can_fill_info <-rtnl_link_fill
>        canconfig-3288  [000]  3756.163066: can_fill_xstats <-rtnl_link_fill
>        canconfig-3288  [000]  3756.163067: can_fill_info <-rtnl_link_fill
>        canconfig-3288  [000]  3756.163073: can_fill_xstats <-rtnl_link_fill
>        canconfig-3288  [000]  3756.163073: can_fill_info <-rtnl_link_fill

Yep, I wanted to check if can_fill_info() is called at all. Actually,
can_fill_info() does not return an error code so what I can think off is
a mismatch in the data structure. What kernel CAN header files did you
use when building libsocketcan?

Next step would be to use "gdb" to find out where the error happend in
the code. Most errors while print an error message, though.

Wolfgang.
