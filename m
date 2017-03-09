From: Hans L <thehans@gmail.com>
Subject: Please explain berr-reporting
Date: Thu, 9 Mar 2017 13:31:02 -0600
Message-ID: <CAFoRp-PrdJvfmTUTBVcRgE+kSwggoObt3K=04qRfD2PWus+ZNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:33960 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750781AbdCITbo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 9 Mar 2017 14:31:44 -0500
Received: by mail-ua0-f182.google.com with SMTP id f54so86574614uaa.1
        for <linux-can@vger.kernel.org>; Thu, 09 Mar 2017 11:31:43 -0800 (PST)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I tried asking this as a part of a larger issue a few months ago and
didn't get any explanation, so I'm trying again, focusing specifically
on this single issue.

Can anyone tell me what enabling berr-reporting does?

It is only mentioned once in this documentation, in the list of ip
link options: https://www.kernel.org/doc/Documentation/networking/can.txt

There seems to be absolutely zero documentation of what this is
supposed to do.  Does anyone know?  Does it really do anything?

Hans
