From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: mailmap
Date: Thu, 6 Oct 2016 14:24:27 +0200
Message-ID: <20161006122427.GF26915@airbook.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b03.edpnet.be ([212.71.1.220]:58803 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941902AbcJFMZ3 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Oct 2016 08:25:29 -0400
Content-Disposition: inline
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Marc,

Besides the legal aspect of squashing the whole j1939 tree, which I did
half on EIA, half in private time, it sure seems a good idea to fix
the email address in .mailmap:
Can you, besides the j1939 stuff, incorporate this one.

I also prepare a MAINTAINERS commit, that should go along with the J1939
stuff....

commit 9989fe341b87f43c3f412a6307fcdc99c4e3d9ca
Author: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Date:   Thu Oct 6 14:15:19 2016

    mailmap: update email address
    
    This commit replaces my company's email address with a stable private
    address.
    
    Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

diff --git a/.mailmap b/.mailmap
index 52489f5..8f1fc01 100644
--- a/.mailmap
+++ b/.mailmap
@@ -89,6 +89,7 @@ Konstantin Khlebnikov <koct9i@gmail.com> <k.khlebnikov@samsung.com>
 Koushik <raghavendra.koushik@neterion.com>
 Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+<dev.kurt@vandijck-laurijssen.be> <kurt.van.dijck@eia.be>
 Leonid I Ananiev <leonid.i.ananiev@intel.com>
 Linas Vepstas <linas@austin.ibm.com>
 Mark Brown <broonie@sirena.org.uk>
