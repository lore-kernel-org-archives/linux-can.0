From: <kime-Z4QKGCRq86k@public.gmane.org>
Subject: RE: CAN State Information
Date: Fri, 9 Dec 2011 09:45:18 +0100
Message-ID: <166589D0B9DD2547A1319599B9BADA1FC1998A@vsv-exchange.ixxat.intranet.priv>
References: <166589D0B9DD2547A1319599B9BADA1FC1960C@vsv-exchange.ixxat.intranet.priv>
	<4EDE342E.8030102@grandegger.com>
	<166589D0B9DD2547A1319599B9BADA1FC1981F@vsv-exchange.ixxat.intranet.priv>
	<4EE10CB4.2090604@grandegger.com>
	<166589D0B9DD2547A1319599B9BADA1FC19968@vsv-exchange.ixxat.intranet.priv>
	<4EE1C3BF.70104@grandegger.com> <4EE1C47A.7080507@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <4EE1C47A.7080507-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
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

I am new to using trace, but I think this is the output you are looking for=
: =


       canconfig-3288  [000]  3756.129866: can_vma_merge_before <-vma_merge
       canconfig-3288  [000]  3756.130035: can_vma_merge_before <-vma_merge
       canconfig-3288  [000]  3756.130116: can_vma_merge_before <-vma_merge
       canconfig-3288  [000]  3756.130234: can_vma_merge_before <-vma_merge
       canconfig-3288  [000]  3756.130366: can_vma_merge_before <-vma_merge
       canconfig-3288  [000]  3756.148522: can_vma_merge_before <-vma_merge
       canconfig-3288  [000]  3756.162588: can_vma_merge_before <-vma_merge
       canconfig-3288  [000]  3756.162641: can_vma_merge_before <-vma_merge
       canconfig-3288  [000]  3756.162653: can_vma_merge_before <-vma_merge
       canconfig-3288  [000]  3756.163033: can_fill_xstats <-rtnl_link_fill
       canconfig-3288  [000]  3756.163034: can_fill_info <-rtnl_link_fill
       canconfig-3288  [000]  3756.163041: can_fill_xstats <-rtnl_link_fill
       canconfig-3288  [000]  3756.163042: can_fill_info <-rtnl_link_fill
       canconfig-3288  [000]  3756.163047: can_fill_xstats <-rtnl_link_fill
       canconfig-3288  [000]  3756.163048: can_fill_info <-rtnl_link_fill
       canconfig-3288  [000]  3756.163066: can_fill_xstats <-rtnl_link_fill
       canconfig-3288  [000]  3756.163067: can_fill_info <-rtnl_link_fill
       canconfig-3288  [000]  3756.163073: can_fill_xstats <-rtnl_link_fill
       canconfig-3288  [000]  3756.163073: can_fill_info <-rtnl_link_fill

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
From: Wolfgang Grandegger [mailto:wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org] =

Sent: Friday, December 09, 2011 9:19 AM
To: Kime, James
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org; linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: Re: CAN State Information

On 12/09/2011 09:15 AM, Wolfgang Grandegger wrote:
> On 12/09/2011 09:03 AM, kime-Z4QKGCRq86k@public.gmane.org wrote:
>> I plan to spend some time today tracking down the problem.  I am most cu=
rious to discover if there is a problem in the msg returned from send_dump_=
request(). =

>>
>> $ sudo ./canconfig can0 state
>> can0 state: STOPPED
>> $ sudo ./canconfig can1 state
>> can1 state: STOPPED
>> $ "
>> can2: failed to get state =

>> $ sudo ./canconfig can3 state
>> can3: failed to get state =

> =

> OK, what does strace tell you. Is there a system call failing with "-1"?
> Also ftrace could give some hint (assuming that ftrace and function
> tracing is enabled in you kernel):
> =

>   # mount -tdebugfs none /sys/kernel/debug/
>   # cd /sys/kernel/debug/tracing/
>   # echo function > current_tracer
>   # echo "can_*" >  set_ftrace_filter
>   # cat set_ftrace_filter
>   # echo 0 > trace

    # echo 1 > tracing_on

might also be necessary (usually it on by default).

Wolfgang.
