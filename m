Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF60C7113B
	for <linux-can@archiver.kernel.org>; Thu, 24 Aug 2023 07:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjHXHrS (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 24 Aug 2023 03:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237890AbjHXHqz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Aug 2023 03:46:55 -0400
Received: from mail.loanfly.pl (mail.loanfly.pl [141.94.250.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E4010D0
        for <linux-can@vger.kernel.org>; Thu, 24 Aug 2023 00:46:53 -0700 (PDT)
Received: by mail.loanfly.pl (Postfix, from userid 1002)
        id 155F8A46E6; Thu, 24 Aug 2023 07:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=loanfly.pl; s=mail;
        t=1692863186; bh=Y0HnXqH+26AP5Uq6M8BQXaj1HIAPQY/WndV9tkpAHHU=;
        h=Date:From:To:Subject:From;
        b=r6P8lbmWogx9dVEOxOddoUaQ7DZPTNIEG+eGFOc11udk6Iuj1co73cb9BWFLtISEZ
         iam7o/I7BK5QSETRC+zZr8/DbdBzJ30v9RiMzkk1VtVkhdTsct0cQXCROIlSS+WI6d
         cq0w9Edvp4haZeH23E+R3tei8U1Dsx0FqAtqR51+OaCRzFahPiLFKjbr1sxSJhSDqv
         MZlp8f3L0xWYwnuRidVrnE3eb90o2jz3zD0vrEdeUGrPDZnJF1tcqXJu9AyaSVl2XP
         sEERILZa5fOdNfz8bYv6mDGtofhQN4OCDLrTAlaD/Ci2fIRTVEF6xTNCwlFBIlDzVv
         rrDjffIwbHI/g==
Received: by mail.loanfly.pl for <linux-can@vger.kernel.org>; Thu, 24 Aug 2023 07:45:43 GMT
Message-ID: <20230824064500-0.1.c3.1d7lr.0.bx4dj8d1de@loanfly.pl>
Date:   Thu, 24 Aug 2023 07:45:43 GMT
From:   "Damian Cichocki" <damian.cichocki@loanfly.pl>
To:     <linux-can@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.loanfly.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Damian Cichocki
