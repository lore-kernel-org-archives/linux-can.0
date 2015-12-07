From: Yang Wang <wang701@purdue.edu>
Subject: Re: J1939 send causes call trace dump
Date: Mon, 7 Dec 2015 11:08:25 -0500
Message-ID: <CAEE8DsLHxJqT62m3AFSrg6DJEqe6VVW0UpFsnWzm8bLQm1hMxQ@mail.gmail.com>
References: <CAEE8DsL73FVDMdVCVC0Z=X5KKiaE=KnTwPNp3gJS37nd7oq9dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailhub248.itcs.purdue.edu ([128.210.5.248]:35226 "EHLO
	mailhub248.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756001AbbLGQI0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Dec 2015 11:08:26 -0500
Received: from mail-yk0-f172.google.com (mail-yk0-f172.google.com [209.85.160.172])
	(authenticated bits=0)
	by mailhub248.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id tB7G8Pto026819
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Mon, 7 Dec 2015 11:08:25 -0500
Received: by ykdv3 with SMTP id v3so199513318ykd.0
        for <linux-can@vger.kernel.org>; Mon, 07 Dec 2015 08:08:25 -0800 (PST)
In-Reply-To: <CAEE8DsL73FVDMdVCVC0Z=X5KKiaE=KnTwPNp3gJS37nd7oq9dA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>

Hi all,

I created a gist of the program that caused the problem:

https://gist.github.com/wang701/7f67dc280f4c323d8c1c

On Mon, Dec 7, 2015 at 1:07 AM, Yang Wang <wang701@purdue.edu> wrote:
> For my program, for binding:
>
> addr.can_addr.j1939.addr = 0x45;
> addr.can_addr.j1939.name = J1939_NO_NAME;
> addr.can_addr.j1939.pgn = 0xF00A;
>
> and for sending, I change j1939.addr to 0x30, allocate a buffer of
> data and send the message using sendto().
>
