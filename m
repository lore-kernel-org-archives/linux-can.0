From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 send causes call trace dump
Date: Wed, 9 Dec 2015 11:54:52 +0100
Message-ID: <20151209105452.GA12447@airbook.vandijck-laurijssen.be>
References: <CAEE8DsL73FVDMdVCVC0Z=X5KKiaE=KnTwPNp3gJS37nd7oq9dA@mail.gmail.com>
 <20151208100515.GD32721@airbook.vandijck-laurijssen.be>
 <CAEE8DsJLjaFVscqpng6sk5-y_7Zzcw4z=bLETxOeAeEXNKi0fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:43162 "EHLO
	relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713AbbLIKzw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 9 Dec 2015 05:55:52 -0500
Content-Disposition: inline
In-Reply-To: <CAEE8DsJLjaFVscqpng6sk5-y_7Zzcw4z=bLETxOeAeEXNKi0fw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yang Wang <wang701@purdue.edu>
Cc: linux-can <linux-can@vger.kernel.org>

> Hello,
> 
> On Tue, Dec 8, 2015 at 5:05 AM, Kurt Van Dijck
> <dev.kurt@vandijck-laurijssen.be> wrote:
> 
> > Can you try checkout j1939-v3.15?
> > It worked on my system, but I had not yet a chance to seriously test
> > that. I'm currently removing rtnetlink requirements.
> 
> Thanks for the advice. Switching to j1939-v3.15 branch works for me,
> no call trace after send. I will test along with my development and
> let you know if I run into issues.

Thanks for verifying j1939-v3.15.

> 
> Regards,
> Yang
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
