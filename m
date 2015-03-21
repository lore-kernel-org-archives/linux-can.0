From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: Kvaser leaf light
Date: Sat, 21 Mar 2015 21:32:44 +0200
Message-ID: <20150321193244.GA30447@Darwish.PC>
References: <20150320075238.GA2387@Darwish.PC>
 <29966613.106.1426846736128.JavaMail.RPO@mac-rpo.local>
 <CAJsV4AxMVP=51OYEQDADsF_iQO7aCRA_T-kXaC0LJp1nyxtM9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:35783 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbbCUTct (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 21 Mar 2015 15:32:49 -0400
Received: by webcq43 with SMTP id cq43so106716724web.2
        for <linux-can@vger.kernel.org>; Sat, 21 Mar 2015 12:32:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJsV4AxMVP=51OYEQDADsF_iQO7aCRA_T-kXaC0LJp1nyxtM9g@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ralph Potztal <ralph.potztal@espros.com>
Cc: linux-can@vger.kernel.org

Hi Ralph,

On Fri, Mar 20, 2015 at 01:00:34PM +0200, Ahmed S. Darwish wrote:
> On Fri, Mar 20, 2015 at 12:18 PM, Ralph Potztal <ralph.potztal@espros.com>
> >
> > $ uname -a
> >
> >   Linux cli-46 3.19.0-031900-generic #201502091451 SMP Mon Feb 9
> >   14:52:52 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux
> >
> > It's working excellent now.
> >
>
> Great. Switch to upcoming v4.0 if you notice any disruptions
> in your CAN traffic. I shall send backported fixes soon.
> 

Backported fixes for v3.19, and other -stable kernels, are now
ready:

    http://article.gmane.org/gmane.linux.can/7857
    http://article.gmane.org/gmane.linux.can/7860
    http://article.gmane.org/gmane.linux.can/7859

Append /raw to the URLs above to get the patches in a form
that can be applied with "patch" or "git am".

Regards,
Darwish
