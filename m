From: JUAN PEDRO RODRIGUEZ NIETO <jprodriguez@elecnor.com>
Subject: PCH_CAN - echo_skb is occupied
Date: Mon, 31 Mar 2014 11:59:44 +0200
Message-ID: <CA+vJB=yJ_tF1UwdwpLMVVYMKpTCQCYhWdFGGQNQNn2iP=1V3-A@mail.gmail.com>
Reply-To: jprodriguez@elecnor.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:53839 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbaCaJ7o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 31 Mar 2014 05:59:44 -0400
Received: by mail-qa0-f52.google.com with SMTP id m5so7790559qaj.39
        for <linux-can@vger.kernel.org>; Mon, 31 Mar 2014 02:59:44 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I am using a Q7 module with Atom processor and EG20T. I am using the
latest Yocto Dora 10.0.0 to build the embedded linux image. This image
is still using pch_can.c driver, with the "echo_skb is occupied"
problem.

I have checked with your post
http://marc.info/?l=3Dlinux-can&m=3D137180949810229&w=3D2
and the source code of pch_can does not have your patch applied.

I am not familiar with kernel patching. Could you please direct me
where can I find the latest pch_can and how to download your patch in
patch file format so I can apply it to my poky build?

Is there any plan to release these patches in the master branch?

Thanks,

Juan Pedro Rodr=EDguez Nieto
Delegaci=F3n de Sistemas




Rambla Solanes, 29-31
08940 Cornell=E0 de Llobregat, Barcelona
Tel.: 934 139 200
=46ax: 934 139 201
