Return-Path: <linux-can-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB56CDB474
	for <linux-can@archiver.kernel.org>; Mon, 23 Oct 2023 07:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjJWHcw (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 23 Oct 2023 03:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWHcv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 23 Oct 2023 03:32:51 -0400
Received: from mail.loanfly.pl (mail.loanfly.pl [141.94.250.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E78C9B
        for <linux-can@vger.kernel.org>; Mon, 23 Oct 2023 00:32:50 -0700 (PDT)
Received: by mail.loanfly.pl (Postfix, from userid 1002)
        id C9FFCA379A; Mon, 23 Oct 2023 07:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=loanfly.pl; s=mail;
        t=1698046332; bh=Y0HnXqH+26AP5Uq6M8BQXaj1HIAPQY/WndV9tkpAHHU=;
        h=Date:From:To:Subject:From;
        b=qpNYkWsFL5tDiUVu/6ycwtQ+IOC13bZQKKgq15BlwUA3g65yAhKvH9P+yMw+wS2nY
         6IXgv1b7SJAsleklfpdmGQouDwxvWyaTd6XwRu4hadiFsbYgwoBoriGtc2fRESTUHb
         aYUmni64tkWcryVFm9O0p/F+hK1+fR/JDQneRzhqkVUzvEiQaNp46lLUbaTQjxrd3m
         EE+qLEeeyDE5nh8AX7e9NJyTTkWjdVmq8E16rH9fDEWIao6l+9lLxWSfRMsagb+9by
         0tMSdCm4M/F6Z9MkgJyqZ6Ns6BDfkWkPvz39t0XIwfLhsiGiLHykNMJQ2rn/iuERcI
         JIgOW8IxajJjw==
Received: by mail.loanfly.pl for <linux-can@vger.kernel.org>; Mon, 23 Oct 2023 07:31:09 GMT
Message-ID: <20231023064501-0.1.da.1keba.0.baknma4f51@loanfly.pl>
Date:   Mon, 23 Oct 2023 07:31:09 GMT
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
