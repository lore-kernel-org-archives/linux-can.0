From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: Expose filtered CAN interface to processes
Date: Mon, 1 Feb 2016 10:13:05 +0000
Message-ID: <20160201101305.GA3878@maxwell.marel.net>
References: <EB7F4954055D8D47BE2774BFC0597392301E1285@MTK-SMS-XCH02.digi.com>
 <56ABC5EE.8070100@hartkopp.net>
 <EB7F4954055D8D47BE2774BFC0597392301E144B@MTK-SMS-XCH02.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0075.outbound.protection.outlook.com ([157.55.234.75]:24422
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753219AbcBAK36 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 1 Feb 2016 05:29:58 -0500
Content-Disposition: inline
In-Reply-To: <EB7F4954055D8D47BE2774BFC0597392301E144B@MTK-SMS-XCH02.digi.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Osborne, Paul" <Paul.Osborne@digi.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Fri, Jan 29, 2016 at 09:53:01PM +0000, Osborne, Paul wrote:
> 
> Hello Oliver/Andri,
> 
> >> I am new to network namespaces; Am I missing something?  Is this a
> >> real use case for network namespace support?  It sounded like there
> >> was uncertainty on this point with the RFC that was posted back in
> >> September by Andri: http://comments.gmane.org/gmane.linux.can/8589.
> >
> > Yes. I think this would be the right way to go.
> >
> > My current idea regarding namespace aware virtual CAN interfaces is to create
> > virtual CAN interfaces inside a network namespace. These 'vcan with namespace'
> > interfaces could then be connected via cangw in the initial (real world)
> > namespace to other can/vcan interfaces (with/without namespace) with cangw rules.
> >
> > The good thing about this approach is that you can use the filter and
> > modification capabilities from cangw at the same time.
> 
> Alright, good to know I am not barking up the wrong tree.  As I am
> needing this functionality in the not-too-distant future, I may take a
> shot at putting something together based on the work Andri has done
> and your comments.
>
That would be much appreciated. My patch set crashes on my SMP system but not on
a non-SMP qemu VM.

Feel free to ask me questions. I'll try to answer to the best of my knowledge.

Thanks,
Andri
