From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: linux-can ISOTP module
Date: Fri, 16 Jan 2015 18:31:40 +0100
Message-ID: <54B94AFC.9080201@hartkopp.net>
References: <loom.20140604T144601-350@post.gmane.org>	<538F6836.3060508@hartkopp.net>	<CAA7hF3w-W1E0E5M4Gkc=0aYB0NQPrOMJfLp-iSG8K8HJU-sdoA@mail.gmail.com>	<539043EA.6030001@artisandeveloppeur.fr>	<5390B575.7030506@hartkopp.net>	<CAA7hF3xomuS-mDRQWmkC=D9YfbDPt+TwXKc7+ZFtUNwkg5cMdQ@mail.gmail.com>	<53A48699.6030605@hartkopp.net>	<CAA7hF3yzM8KZjj+4d8m2rUZaDWPuC2hygYZ6PzFz4jWu1Y8e_A@mail.gmail.com>	<5464EEC4.1080009@hartkopp.net> <CAA7hF3ypuVbfxbskM+2bn_58a-k0EtCePxQ_1i6j24G5H=zFSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:37475 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbbAPRbv (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 16 Jan 2015 12:31:51 -0500
In-Reply-To: <CAA7hF3ypuVbfxbskM+2bn_58a-k0EtCePxQ_1i6j24G5H=zFSQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>
Cc: maxime@artisandeveloppeur.fr, linux-can@vger.kernel.org

On 15.01.2015 09:45, laurent vaudoit wrote:

> On Thu, Nov 13, 2014 at 6:47 PM, Oliver Hartkopp <socketcan@hartkopp.net


>     >> I added the funtionality of a different rx_ext_addr to a specific branch of
>     >> can-utils and can-modules:
>     >>
>     >>https://gitorious.org/linux-can/can-utils/commits/rx_ext_addr
>     >>https://gitorious.org/linux-can/can-modules/commits/rx_ext_addr
>     >>
>     >> Please check them out for a test. As all the isotp tools (in the branch)
>     >> support the new feature too, it should be easy to do.
>     >
>     > i did not have time for test but regarding the source code, it should be ok.

(..)
>
> it works well.
> I've made some tests sending single frame and segmented frame
> and receiving some single frame, with different extended adressing mode.
>
> We are now able to deal with all the addressing method of the Iso15765-2.

Great! Many thanks for testing!

> Branch can be merge (by the way it seems kernel evolution is allready merged
> into master).

Yes, I had some other stuff to add for a complete ISO15765-2:2015 support, 
e.g. the 32 bit FF_DL and the checks for optimized frame length.

So I needed to extend the API step by step and the rx_ext_addr was already 
defined - therefore it was hard to continue with integrating new features.

But it's good to know that it fits your needs and the isotp got 'even better' 
for all use cases in the wild :-)

Best regards,
Oliver

