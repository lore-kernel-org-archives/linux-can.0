From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: need support J1939 protocol support to my kernel (v3.8 on
 BeagleBone Black)
Date: Sun, 10 Nov 2013 18:21:04 +0100
Message-ID: <20131110172104.GA30075@vandijck-laurijssen.be>
References: <CAO4rUqy5JKE=nwpfRC7qShLGeizyV0a-CzUyV51g=tEe671z8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:1529 "EHLO
	mailrelay010.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751531Ab3KJRVS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Sun, 10 Nov 2013 12:21:18 -0500
Content-Disposition: inline
In-Reply-To: <CAO4rUqy5JKE=nwpfRC7qShLGeizyV0a-CzUyV51g=tEe671z8g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Swapnil Patil <patilswa@gmail.com>
Cc: linux-can@vger.kernel.org

Hi,

Thanks for your interest in this J1939 module.
Please note taht the mailing list for discussions about this
is linux-can@vger.kernel.org.

I personnaly have not tried anything on a BeagleBoneBlack, but I know
people who have used can-j1939 on this device.
I do not have the details about which system they used: ubuntu, ...

Please find my answers below.

On Sun, Nov 10, 2013 at 01:29:17AM -0500, Swapnil Patil wrote:
>  
> Hi  Kurt,
>  
>              Can u share the details that how you have configared j1939 in
> begalbone black
> I have tried on my begalbone ubuntu 13.04 and amstrong but not able to compile
> j1939

The way you described your situation gives not many details.
Can you give more detail what exactly fails to compile, and how that fails?

>  
> if u forward the steps it will be a great help for me

I'll describe very high level the steps here:

* kernel
	* grab kernel sources
	* merge can-j1939 git
	* compile kernel
* optionally fix some headers in your cross-compiler
* grab+compile can-utils-j1939
* grab+compile iproute2-j1939

>  
>  i get an error
> 
> Error: either "dev" is duplicate, or "j1939" is a garbage

From what I can tell, this is not a compile problem.
This is the ip tool that cannot parse the j1939 command line.

You should use a j1939-enabled iproute2.

Kind regards,
Kurt Van Dijck
