From: Yang Wang <wang701@purdue.edu>
Subject: Re: J1939 send causes call trace dump
Date: Tue, 8 Dec 2015 20:08:17 -0500
Message-ID: <CAEE8DsJLjaFVscqpng6sk5-y_7Zzcw4z=bLETxOeAeEXNKi0fw@mail.gmail.com>
References: <CAEE8DsL73FVDMdVCVC0Z=X5KKiaE=KnTwPNp3gJS37nd7oq9dA@mail.gmail.com>
	<20151208100515.GD32721@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailhub246.itcs.purdue.edu ([128.210.5.246]:56022 "EHLO
	mailhub246.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751934AbbLIBIT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Dec 2015 20:08:19 -0500
Received: from mail-qg0-f50.google.com (mail-qg0-f50.google.com [209.85.192.50])
	(authenticated bits=0)
	by mailhub246.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id tB918Ioc028606
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Tue, 8 Dec 2015 20:08:18 -0500
Received: by qgeb1 with SMTP id b1so48775504qge.1
        for <linux-can@vger.kernel.org>; Tue, 08 Dec 2015 17:08:17 -0800 (PST)
In-Reply-To: <20151208100515.GD32721@airbook.vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, dev.kurt@vandijck-laurijssen.be

Hello,

On Tue, Dec 8, 2015 at 5:05 AM, Kurt Van Dijck
<dev.kurt@vandijck-laurijssen.be> wrote:

> Can you try checkout j1939-v3.15?
> It worked on my system, but I had not yet a chance to seriously test
> that. I'm currently removing rtnetlink requirements.

Thanks for the advice. Switching to j1939-v3.15 branch works for me,
no call trace after send. I will test along with my development and
let you know if I run into issues.

Regards,
Yang
