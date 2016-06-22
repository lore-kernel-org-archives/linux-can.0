From: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [PATCH v2 0/2] can: rcar_canfd: Add Classical CAN & lower state
 transition support
Date: Wed, 22 Jun 2016 13:31:45 +0100
Message-ID: <1466598707-44076-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1466434007-50873-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466434007-50873-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: mkl@pengutronix.de, wg@grandegger.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: devicetree@vger.kernel.org, chris.paterson2@renesas.com, socketcan@hartkopp.net, magnus.damm@gmail.com, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, horms@verge.net.au, ulrich.hecht+renesas@gmail.com, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-can.vger.kernel.org

This patch is based on latest can-next(tag:linux-can-next-for-4.8-20160617).

Changes since v1:
 - property named changed from "can-nofd" to "no-can-fd" (Rob H)
 - added new patch(0002) that support lower state transitions (Wolfgang G)
   (http://marc.info/?l=linux-can&m=146650325116971&w=2)

Ramesh Shanmugasundaram (2):
  can: rcar_canfd: Add Classical CAN only mode support
  can: rcar_canfd: Add back-to-error-active support

 .../devicetree/bindings/net/can/rcar_canfd.txt     |  21 +-
 drivers/net/can/rcar/rcar_canfd.c                  | 429 ++++++++++++++-------
 2 files changed, 310 insertions(+), 140 deletions(-)

-- 
1.9.1
