From: Willy Lambert <lambert.willy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Using sja1000_isa on a 64b system
Date: Wed, 9 Nov 2011 19:03:29 +0100
Message-ID: <CAKvQZ_28skey9u+rDXi8mkrYiuhTQwnUAAhNMsPNqT-ZP3VNkg@mail.gmail.com>
References: <CAKvQZ_3HSdfOn4xGq7j8GsWJ+iHVan0Ygr=tR+cQm-tpQQWV2A@mail.gmail.com>
	<4E4CA945.7080504@hartkopp.net> <4E4CC9D5.6040708@pengutronix.de>
	<CAKvQZ_0raVFUsCFYA2FVH_138DCMw6ipKHdz=Dh62K4YpM5o=Q@mail.gmail.com>
	<4E5CCAA5.4030009@grandegger.com>
	<CAKvQZ_0TFUd4FwOvr4AXArviMYPGHH6Xex4Cjy7LxYoEuBUpxA@mail.gmail.com>
	<4E6271CD.6040407@grandegger.com>
	<CAKvQZ_2PyM5zo5-4PtrMGjMEML3j02MKCCJU=zpnkSK2N_XUjg@mail.gmail.com>
	<4E64B6CB.8010505@grandegger.com>
	<CAKvQZ_1gp9XvVmh+ZEUdEVz2TrvkhHtVKc20ViNgSx=uuPWajQ@mail.gmail.com>
	<4E653775.4030503@grandegger.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0847604463866428922=="
Return-path: <socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <4E653775.4030503-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-users>
List-Post: <mailto:socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-users>,
	<mailto:socketcan-users-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-users-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: "socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org" <socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

--===============0847604463866428922==
Content-Type: multipart/alternative; boundary=f46d041826acfd42b004b1511a75

--f46d041826acfd42b004b1511a75
Content-Type: text/plain; charset=ISO-8859-1

2011/9/5 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>

> On 09/05/2011 07:35 PM, Willy Lambert wrote:
> > 2011/9/5 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
> >
> >> On 09/04/2011 09:09 PM, Willy Lambert wrote:
> >>> 2011/9/3 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
> >> ...
> >>>> What CAN hardware are you using?
> >>>
> >>>
> >>> Motherboad and CAN stack :
> >>>
> >>
> http://www.advantech.com/products/PCM-3362/mod_2B69DA4C-D506-4AEA-8CC3-F6E58E3CBC87.aspx
> >>> http://www.ixxat.com/pc_i_04_104_en.html
> >>
> >> OK...
> >>
> >>>> And what bus is it
> >>>> connected to? Why do I ask? In "arch/x86/Kconfig" there is:
> >>>>
> >>>>  # x86_64 have no ISA slots, but can have ISA-style DMA.
> >>>>  config ISA_DMA_API
> >>>>        bool "ISA-style DMA support" if (X86_64 && EXPERT)
> >>>>        default y
> >>>>        help
> >>>>          Enables ISA-style DMA support for devices requiring such
> >>>> controllers.
> >>>>          If unsure, say Y.
> >>>>
> >>>>  if X86_32
> >>>>
> >>>>  config ISA
> >>>>        bool "ISA support"
> >>>>        ---help---
> >>>>          Find out whether you have ISA slots on your motherboard.  ISA
> >> is
> >>>> the
> >>>>          name of a bus system, i.e. the way the CPU talks to the other
> >>>> stuff
> >>>>          inside your box.  Other bus systems are PCI, EISA,
> MicroChannel
> >>>>          (MCA) or VESA.  ISA is an older system, now being displaced
> by
> >>>> PCI;
> >>>>          newer boards don't support it.  If you have ISA, say Y,
> >> otherwise
> >>>> N.
> >>>>
> >>>>
> >>>> Maybe the assumption that the x86_64 does not have ISA slots is wrong
> >> and
> >>>> we
> >>>> should fix that instead of moving to a platform driver like Oliver
> >>>> suggested.
> >>
> >> Intel Atom N450 on that board supports the PC/104-Plus bus, which is PCI
> >> (not ISA) based, therefore a SJA1000-PCI-driver seems more appropriate.
> >> Do you find the SJA1000 device with "lspci -vv"?
>
> Ah, at a closer look, the PC/104-Plus is an extension of the PC/104 from
> factor with an additional connector for PCI. It therefore still supports
> ISA bus communication, which the IXXAT PC-I 04/104 board uses.
>
> Therefore I'm going to prepare a patch removing the "X86_32" restriction
> for CONFIG_ISA above. Sorry for confusion.
>

May I bump this up ? I read your conversation on other linux ML, but I
don't really know how it ended.


>
> Wolfgang.
>

--f46d041826acfd42b004b1511a75
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/9/5 Wolfgang Grandegger <span dir=
=3D"ltr">&lt;<a href=3D"mailto:wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org">wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org</a>&gt;=
</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"HOEnZb"><div class=3D"h5">On 09/05/2011 07:35 PM, Willy Lambe=
rt wrote:<br>
&gt; 2011/9/5 Wolfgang Grandegger &lt;<a href=3D"mailto:wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org">=
wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt;&gt; On 09/04/2011 09:09 PM, Willy Lambert wrote:<br>
&gt;&gt;&gt; 2011/9/3 Wolfgang Grandegger &lt;<a href=3D"mailto:wg@grandegg=
er.com">wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org</a>&gt;<br>
&gt;&gt; ...<br>
&gt;&gt;&gt;&gt; What CAN hardware are you using?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Motherboad and CAN stack :<br>
&gt;&gt;&gt;<br>
&gt;&gt; <a href=3D"http://www.advantech.com/products/PCM-3362/mod_2B69DA4C=
-D506-4AEA-8CC3-F6E58E3CBC87.aspx" target=3D"_blank">http://www.advantech.c=
om/products/PCM-3362/mod_2B69DA4C-D506-4AEA-8CC3-F6E58E3CBC87.aspx</a><br>

&gt;&gt;&gt; <a href=3D"http://www.ixxat.com/pc_i_04_104_en.html" target=3D=
"_blank">http://www.ixxat.com/pc_i_04_104_en.html</a><br>
&gt;&gt;<br>
&gt;&gt; OK...<br>
&gt;&gt;<br>
&gt;&gt;&gt;&gt; And what bus is it<br>
&gt;&gt;&gt;&gt; connected to? Why do I ask? In &quot;arch/x86/Kconfig&quot=
; there is:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =A0# x86_64 have no ISA slots, but can have ISA-style DMA.=
<br>
&gt;&gt;&gt;&gt; =A0config ISA_DMA_API<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0bool &quot;ISA-style DMA support&quot; if (=
X86_64 &amp;&amp; EXPERT)<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0default y<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0help<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0Enables ISA-style DMA support for devic=
es requiring such<br>
&gt;&gt;&gt;&gt; controllers.<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0If unsure, say Y.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =A0if X86_32<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =A0config ISA<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0bool &quot;ISA support&quot;<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0---help---<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0Find out whether you have ISA slots on =
your motherboard. =A0ISA<br>
&gt;&gt; is<br>
&gt;&gt;&gt;&gt; the<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0name of a bus system, i.e. the way the =
CPU talks to the other<br>
&gt;&gt;&gt;&gt; stuff<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0inside your box. =A0Other bus systems a=
re PCI, EISA, MicroChannel<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0(MCA) or VESA. =A0ISA is an older syste=
m, now being displaced by<br>
&gt;&gt;&gt;&gt; PCI;<br>
&gt;&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0newer boards don&#39;t support it. =A0I=
f you have ISA, say Y,<br>
&gt;&gt; otherwise<br>
&gt;&gt;&gt;&gt; N.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Maybe the assumption that the x86_64 does not have ISA slo=
ts is wrong<br>
&gt;&gt; and<br>
&gt;&gt;&gt;&gt; we<br>
&gt;&gt;&gt;&gt; should fix that instead of moving to a platform driver lik=
e Oliver<br>
&gt;&gt;&gt;&gt; suggested.<br>
&gt;&gt;<br>
&gt;&gt; Intel Atom N450 on that board supports the PC/104-Plus bus, which =
is PCI<br>
&gt;&gt; (not ISA) based, therefore a SJA1000-PCI-driver seems more appropr=
iate.<br>
&gt;&gt; Do you find the SJA1000 device with &quot;lspci -vv&quot;?<br>
<br>
</div></div>Ah, at a closer look, the PC/104-Plus is an extension of the PC=
/104 from<br>
factor with an additional connector for PCI. It therefore still supports<br=
>
ISA bus communication, which the IXXAT PC-I 04/104 board uses.<br>
<br>
Therefore I&#39;m going to prepare a patch removing the &quot;X86_32&quot; =
restriction<br>
for CONFIG_ISA above. Sorry for confusion.<br></blockquote><div><br></div><=
div>May I bump this up ? I read your conversation on other linux ML, but I =
don&#39;t really know how it ended.</div><div>=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex;">

<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Wolfgang.<br>
</font></span></blockquote></div><br>

--f46d041826acfd42b004b1511a75--

--===============0847604463866428922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Socketcan-users mailing list
Socketcan-users-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
https://lists.berlios.de/mailman/listinfo/socketcan-users

--===============0847604463866428922==--
