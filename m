Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7A29BD87;
	Thu, 22 Jan 2026 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083854; cv=none; b=svn0lkkUKcD72+9Ht44RgKma6hPIKkYgYU1qIcVjo5+m9UvDAdsyR2Sk4HaQz6NlUzfPh055QCHm4GEKo7kuwXO6qkkUmAaWSNkqOktph7yRkKDEXMwvL06OHiRwoy8wTEMlICB6qSWAQNGIT1VvGrKzIZ3pdp0uz2BoaiEVd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083854; c=relaxed/simple;
	bh=Q44E3xwiEgb3KXyksv+EvjEZRdFyqaUMhjUU8o1/htg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmCszLDkggFhA+ycVzL/7bVfJ7S+2GC2TyrBW221eBVvyqYMl/zvZYZtJk6JhDUJ1xWVM+vnYHxTPqeSwOXtvoNP+2rlNG7o0bNJghTiPI7aOUe47n5x9+6Bj1/H5squAgvLqOhaQnJRlS5n3SfpAvaoFwJ+WtrwU3IfLABVOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Sh1II+Nu reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Sh1II+Nu"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dxfz82dlDz1FDXf;
	Thu, 22 Jan 2026 13:10:44 +0100 (CET)
Received: from d-5xj5g74.got.gaisler.com.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dxfz80Ql6z1DDC3;
	Thu, 22 Jan 2026 13:10:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769083844;
	bh=ommVJYfmgEVLR0IO2+iEOe6KsXxJEP6GjOwnH4J7eCk=;
	h=From:To:Cc:Subject:Date;
	b=Sh1II+Nuze12lgGKM6g3XIqqa2HyQvDodWItgxBFhj5gscE5NYJQ0DuSaN2F+g3FT
	 5xIDolbHfLdENWeL/dvHxnbq8UqqlS7c56eVvUM51Duugmtad9b0syDfrnry93B+jd
	 N+NDI5uy0dMU+zh8DI6TPmDQ2UlOAQ6VLW4fNMvYhgtfbKFpJ4CV+SLm3U2kmPt6Oq
	 5T3jyTSexK+1yU+tDvGTYIz+ZOFgjIcMKeGknGnPFW0yg8yP4c8u6uNEoDyPEu4Vr/
	 zkswwI2O8/aiO0Pp2QCMWRtrXjh5BtEyWEgVQ5Y2ZQKeRXjeZq49zPpBfPI6+vIROt
	 xpO6gDjNmyUuA==
From: Arun Muthusamy <arun.muthusamy@gaisler.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mkl@pengutronix.de,
	mailhol@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	Arun Muthusamy <arun.muthusamy@gaisler.com>
Subject: [PATCH v3 00/15] can: grcan: Enhance driver with CANFD Support and Improvemens
Date: Thu, 22 Jan 2026 13:10:23 +0100
Message-ID: <20260122121038.7910-1-arun.muthusamy@gaisler.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series updates the GRCAN driver to support the GRCANFD core
from the GRLIB IP core library.

In addition to GRCANFD support, the updates include enhancements for
compatibility with NOEL-V (RISC-V) systems, such as matching drivers
using the 'compatible' identifier and adding support for reading clock
frequency via the common clock framework where available. The series
also includes improvements like functions for configuring
nominal bit-timing and optimizations for DMA operations.

This series also updates the driver documentation and bindings.
The old text binding is converted to YAML, a new vendor prefix
is added to reflect the updated ownership and an entry for the
driver is added to the MAINTAINERS file.

Arun Muthusamy (9):
  net: can: Convert gaisler,grcan to DT schema
  MAINTAINERS: Add maintainers for GRCAN CAN network driver
  can: grcan: Replace bit timing macros with literal values
  can: grcan: Simplify timing configuration
  can: grcan: add FD capability detection and nominal bit-timing
  can: grcan: Advertise CANFD capability
  can: grcan: Add CANFD TX support alongside legacy CAN
  can: grcan: Add CANFD RX support alongside legacy CAN
  can: grcan: Update echo skb handling to match variable length CANFD
    frame

Daniel Hellstrom (5):
  can: grcan: Add clock handling
  can: grcan: optimize DMA by 32-bit accesses
  can: grcan: set DMA mask for GRCAN and GRCANFD to 32-bit
  can: grcan: Add saving and restoring of CAN FD baud-rate registers
  can: grcan: Reserve space between cap and next register to align with
    address layout

Ludwig Rydberg (1):
  dt-bindings: Add vendor prefix for Frontgrade Gaisler AB

Changes in v3:
- can: Replaced custom bit shifting with FIELD_PREP and GENMASK.
- can: Factorized common elements of struct canfd_frame and
    struct can_frame, excluding DLC assignment.
- can: Split the patch to separate code refactoring from the
    introduction of the new feature.
- can: Remove Unused macros
- Link to v2: https://lore.kernel.org/all/20251223105604.12675-1-arun.muthusamy@gaisler.com/

Changes in v2:
- bindings: Updated commit message to explain the removal of freq
  and systemid in the new binding.
- can: S-o-b is placed last in commit messages.
- can: Add values are directly added to the struct can_bittiming_const.
- can: Replaced custom bit shifting with FIELD_PREP and GENMASK for clarity.
- can: Drop do_set_bittiming() callback
- can: Remove forward declarations, unnecessary parentheses, redundant comments
  and unnecessary debug printouts.
- can: Refactored variable declarations to follow the reverse-xmas-tree style.
- can: Adjust line breaks according to new character limits
- can: Eliminating unnecessary defines
- can: Enhance code efficiency with memcpy, use standard API to fetch device specific data and
  error handling.
- Link to v1: https://lore.kernel.org/all/20251118092115.3455-1-arun.muthusamy@gaisler.com/

 .../bindings/net/can/gaisler,grcan.yaml       |  62 +++
 .../devicetree/bindings/net/can/grcan.txt     |  28 -
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/net/can/Kconfig                       |   6 +-
 drivers/net/can/grcan.c                       | 507 +++++++++++++-----
 6 files changed, 439 insertions(+), 174 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/gaisler,grcan.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt


base-commit: 4001bda0cc911fcdd3dde36963a17f4eac173d7d
--
2.51.0

