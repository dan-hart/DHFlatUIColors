import XCTest
import DHFlatUIColors

final class CompatibilityTests: XCTestCase {
    func testPreferredPaletteAccessAndUniqueEnumeration() {
        XCTAssertEqual(DHFlatUIColors.Palette.classic.colors, DHFlatUIColors.ClassicPalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.ClassicPalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.breeze.colors, DHFlatUIColors.BreezePalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.BreezePalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.daybreak.colors, DHFlatUIColors.DaybreakPalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.DaybreakPalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.lantern.colors, DHFlatUIColors.LanternPalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.LanternPalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.confetti.colors, DHFlatUIColors.ConfettiPalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.ConfettiPalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.sunroom.colors, DHFlatUIColors.SunroomPalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.SunroomPalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.tapestry.colors, DHFlatUIColors.TapestryPalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.TapestryPalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.tidepool.colors, DHFlatUIColors.TidepoolPalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.TidepoolPalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.pinwheel.colors, DHFlatUIColors.PinwheelPalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.PinwheelPalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.wildflower.colors, DHFlatUIColors.WildflowerPalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.WildflowerPalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.keepsake.colors, DHFlatUIColors.KeepsakePalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.KeepsakePalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.kiln.colors, DHFlatUIColors.KilnPalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.KilnPalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.signal.colors, DHFlatUIColors.SignalPalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.SignalPalette.allCases).count, 20)
        XCTAssertEqual(DHFlatUIColors.Palette.sherbet.colors, DHFlatUIColors.SherbetPalette.allCases.map(\.info))
        XCTAssertEqual(Set(DHFlatUIColors.SherbetPalette.allCases).count, 20)
        XCTAssertEqual(Set(DHFlatUIColors.Palette.allCases).count, 15)
    }

    // Deprecation warnings are intentional: this protects existing client expressions.
    func testLegacyAndPreferredNamesReferToTheSameValues() {
        XCTAssertEqual(DHFlatUIColors.Palette.flatUiV1, .classic)
        XCTAssertEqual(DHFlatUIColors.Flatuiv1Palette.allCases, DHFlatUIColors.ClassicPalette.allCases)
        XCTAssertEqual(DHFlatUIColors.Flatuiv1Palette.peterRiver, DHFlatUIColors.ClassicPalette.riverBlue)
        XCTAssertEqual(DHFlatUIColors.Flatuiv1Palette.belizeHole, DHFlatUIColors.ClassicPalette.deepWater)
        XCTAssertEqual(DHFlatUIColors.Palette.american, .breeze)
        XCTAssertEqual(DHFlatUIColors.AmericanPalette.allCases, DHFlatUIColors.BreezePalette.allCases)
        XCTAssertEqual(DHFlatUIColors.AmericanPalette.americanRiver, DHFlatUIColors.BreezePalette.riverStone)
        XCTAssertEqual(DHFlatUIColors.AmericanPalette.orangeville, DHFlatUIColors.BreezePalette.bakedClay)
        XCTAssertEqual(DHFlatUIColors.Palette.aussie, .daybreak)
        XCTAssertEqual(DHFlatUIColors.AussiePalette.allCases, DHFlatUIColors.DaybreakPalette.allCases)
        XCTAssertEqual(DHFlatUIColors.AussiePalette.greenlandGreen, DHFlatUIColors.DaybreakPalette.lagoon)
        XCTAssertEqual(DHFlatUIColors.AussiePalette.deepKoamaru, DHFlatUIColors.DaybreakPalette.midnightInk)
        XCTAssertEqual(DHFlatUIColors.Palette.british, .lantern)
        XCTAssertEqual(DHFlatUIColors.BritishPalette.allCases, DHFlatUIColors.LanternPalette.allCases)
        XCTAssertEqual(DHFlatUIColors.BritishPalette.seabrook, DHFlatUIColors.LanternPalette.harborBlue)
        XCTAssertEqual(DHFlatUIColors.Palette.canadian, .confetti)
        XCTAssertEqual(DHFlatUIColors.CanadianPalette.allCases, DHFlatUIColors.ConfettiPalette.allCases)
        XCTAssertEqual(DHFlatUIColors.CanadianPalette.wildCaribbeanGreen, DHFlatUIColors.ConfettiPalette.seaGlass)
        XCTAssertEqual(DHFlatUIColors.CanadianPalette.bleuDeFrance, DHFlatUIColors.ConfettiPalette.clearBlue)
        XCTAssertEqual(DHFlatUIColors.Palette.chinese, .sunroom)
        XCTAssertEqual(DHFlatUIColors.ChinesePalette.allCases, DHFlatUIColors.SunroomPalette.allCases)
        XCTAssertEqual(DHFlatUIColors.ChinesePalette.frenchSkyBlue, DHFlatUIColors.SunroomPalette.openSky)
        XCTAssertEqual(DHFlatUIColors.ChinesePalette.brightGreek, DHFlatUIColors.SunroomPalette.vividIris)
        XCTAssertEqual(DHFlatUIColors.Palette.dutch, .tapestry)
        XCTAssertEqual(DHFlatUIColors.DutchPalette.allCases, DHFlatUIColors.TapestryPalette.allCases)
        XCTAssertEqual(DHFlatUIColors.DutchPalette.mediterraneanSea, DHFlatUIColors.TapestryPalette.deepLagoon)
        XCTAssertEqual(DHFlatUIColors.DutchPalette.turkishAqua, DHFlatUIColors.TapestryPalette.shadedTeal)
        XCTAssertEqual(DHFlatUIColors.Palette.french, .tidepool)
        XCTAssertEqual(DHFlatUIColors.FrenchPalette.allCases, DHFlatUIColors.TidepoolPalette.allCases)
        XCTAssertEqual(DHFlatUIColors.FrenchPalette.azraqBlue, DHFlatUIColors.TidepoolPalette.duskBlue)
        XCTAssertEqual(DHFlatUIColors.FrenchPalette.icelandPoppy, DHFlatUIColors.TidepoolPalette.amberPetal)
        XCTAssertEqual(DHFlatUIColors.Palette.german, .pinwheel)
        XCTAssertEqual(DHFlatUIColors.GermanPalette.allCases, DHFlatUIColors.PinwheelPalette.allCases)
        XCTAssertEqual(DHFlatUIColors.GermanPalette.nycTaxi, DHFlatUIColors.PinwheelPalette.goldenCab)
        XCTAssertEqual(DHFlatUIColors.Palette.indian, .wildflower)
        XCTAssertEqual(DHFlatUIColors.IndianPalette.allCases, DHFlatUIColors.WildflowerPalette.allCases)
        XCTAssertEqual(DHFlatUIColors.IndianPalette.sarawakWhitePepper, DHFlatUIColors.WildflowerPalette.paleLinen)
        XCTAssertEqual(DHFlatUIColors.IndianPalette.keppel, DHFlatUIColors.WildflowerPalette.gardenTeal)
        XCTAssertEqual(DHFlatUIColors.IndianPalette.georgiaPeach, DHFlatUIColors.WildflowerPalette.peachBlossom)
        XCTAssertEqual(DHFlatUIColors.Palette.russian, .keepsake)
        XCTAssertEqual(DHFlatUIColors.RussianPalette.allCases, DHFlatUIColors.KeepsakePalette.allCases)
        XCTAssertEqual(DHFlatUIColors.RussianPalette.appleValley, DHFlatUIColors.KeepsakePalette.rosewater)
        XCTAssertEqual(DHFlatUIColors.RussianPalette.blueCuracao, DHFlatUIColors.KeepsakePalette.blueRipple)
        XCTAssertEqual(DHFlatUIColors.RussianPalette.biscay, DHFlatUIColors.KeepsakePalette.eveningSlate)
        XCTAssertEqual(DHFlatUIColors.Palette.spanish, .kiln)
        XCTAssertEqual(DHFlatUIColors.SpanishPalette.allCases, DHFlatUIColors.KilnPalette.allCases)
        XCTAssertEqual(DHFlatUIColors.SpanishPalette.palmSpringsSplash, DHFlatUIColors.KilnPalette.poolside)
        XCTAssertEqual(DHFlatUIColors.SpanishPalette.chileanFire, DHFlatUIColors.KilnPalette.emberClay)
        XCTAssertEqual(DHFlatUIColors.SpanishPalette.alamedaOchre, DHFlatUIColors.KilnPalette.toastedOchre)
        XCTAssertEqual(DHFlatUIColors.Palette.swedish, .signal)
        XCTAssertEqual(DHFlatUIColors.SwedishPalette.allCases, DHFlatUIColors.SignalPalette.allCases)
        XCTAssertEqual(DHFlatUIColors.SwedishPalette.londonSquare, DHFlatUIColors.SignalPalette.pavement)
        XCTAssertEqual(DHFlatUIColors.Palette.turkish, .sherbet)
        XCTAssertEqual(DHFlatUIColors.TurkishPalette.allCases, DHFlatUIColors.SherbetPalette.allCases)
        XCTAssertEqual(DHFlatUIColors.TurkishPalette.balticSea, DHFlatUIColors.SherbetPalette.charcoal)
    }

    func testPaletteAndLegacyColorSwitchesAreExhaustive() {
        XCTAssertTrue(DHFlatUIColors.Palette.allCases.allSatisfy { palette in
            switch palette {
            case .flatUiV1, .american, .aussie, .british, .canadian, .chinese, .dutch, .french, .german, .indian, .russian, .spanish, .swedish, .turkish, .simple: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.Flatuiv1Palette.allCases.allSatisfy { color in
            switch color {
            case .turquoise, .emerald, .peterRiver, .amethyst, .wetAsphalt, .greenSea, .nephritis, .belizeHole, .wisteria, .midnightBlue, .sunFlower, .carrot, .alizarin, .clouds, .concrete, .orange, .pumpkin, .pomegranate, .silver, .asbestos: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.AmericanPalette.allCases.allSatisfy { color in
            switch color {
            case .lightGreenishBlue, .fadedPoster, .greenDarnerTail, .shyMoment, .cityLights, .mintLeaf, .robinsEggBlue, .electronBlue, .exodusFruit, .soothingBreeze, .sourLemon, .firstDate, .pinkGlamour, .pico8Pink, .americanRiver, .brightYarrow, .orangeville, .chigong, .prunusAvium, .draculaOrchid: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.AussiePalette.allCases.allSatisfy { color in
            switch color {
            case .beekeeper, .spicedNectarine, .pinkGlamour, .juneBud, .coastalBreeze, .turbo, .quinceJelly, .carminePink, .pureApple, .hintOfIcePack, .middleBlue, .heliotrope, .exodusFruit, .deepKoamaru, .soaringEagle, .greenlandGreen, .steelPink, .blurple, .deepCove, .wizardGrey: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.BritishPalette.allCases.allSatisfy { color in
            switch color {
            case .protossPylon, .periwinkle, .risenshine, .downloadProgress, .seabrook, .vanadylBlue, .mattPurple, .nanohanachaGold, .skirretGreen, .naval, .nasturcianFlower, .lynxWhite, .blueberrySoda, .mazarineBlue, .blueNights, .harleyDavidsonOrange, .hintOfPensive, .chainGangGrey, .picoVoid, .electromagnetic: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.CanadianPalette.allCases.allSatisfy { color in
            switch color {
            case .jigglypuff, .casandoraYellow, .pastelRed, .megaman, .wildCaribbeanGreen, .liánHóngLotusPink, .doubleDragonSkin, .amour, .cyanite, .darkMountainMeadow, .jadeDust, .joustBlue, .nasuPurple, .lightBlueBallerina, .fuelTown, .aquaVelvet, .bleuDeFrance, .bluebell, .stormPetrel, .imperialPrimer: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.ChinesePalette.allCases.allSatisfy { color in
            switch color {
            case .goldenSand, .coral, .wildWatermelon, .peace, .grisaille, .orange, .bruschettaTomato, .watermelon, .bayWharf, .prestigeBlue, .limeSoap, .frenchSkyBlue, .saturatedSky, .white, .cityLights, .ufoGreen, .clearChill, .brightGreek, .antiflashWhite, .twinkleBlue: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.DutchPalette.allCases.allSatisfy { color in
            switch color {
            case .sunflower, .energos, .blueMartina, .lavenderRose, .baraRed, .radiantYellow, .androidGreen, .mediterraneanSea, .lavenderTea, .veryBerry, .puffinsBill, .pixelatedGrass, .merchantMarineBlue, .forgottenPurple, .hollyhock, .redPigment, .turkishAqua, .leaguesUnderTheSea, .circumorbitalRing, .magentaPurple: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.FrenchPalette.allCases.allSatisfy { color in
            switch color {
            case .flatFlesh, .melonMelody, .livid, .spray, .paradiseGreen, .squashBlossom, .mandarinRed, .azraqBlue, .dupain, .auroraGreen, .icelandPoppy, .tomatoRed, .yuèGuāngLánBlue, .goodSamaritan, .waterfall, .carrotOrange, .jalapenoRed, .darkSapphire, .forestBlues, .reefEncounter: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.GermanPalette.allCases.allSatisfy { color in
            switch color {
            case .fusionRed, .orangeHibiscus, .flirtatious, .reptileGreen, .maximumBlueGreen, .desire, .beniukonBronze, .nycTaxi, .algalFuel, .turquoiseTopaz, .highBlue, .c64Ntsc, .lighterPurple, .twinkleBlue, .blueGrey, .boyzone, .royalBlue, .gloomyPurple, .innuendo, .blueHorizon: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.IndianPalette.allCases.allSatisfy { color in
            switch color {
            case .orchidOrange, .spiroDiscoBall, .honeyGlow, .sweetGarden, .fallingStar, .richGardenia, .clearChill, .sarawakWhitePepper, .keppel, .shipsOfficer, .fieryFuchsia, .bluebell, .georgiaPeach, .oasisStream, .brightUbe, .magentaPurple, .endingNavyBlue, .sasquatchSocks, .pineGlade, .highlighterLavender: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.RussianPalette.allCases.allSatisfy { color in
            switch color {
            case .creamyPeach, .rosyHighlight, .softBlue, .brewedMustard, .oldGeranium, .sawtoothAak, .summertime, .cornflower, .tigerlily, .deepRose, .purpleMountainMajesty, .roguePink, .squeaky, .appleValley, .pencilLead, .purpleCorallite, .flamingoPink, .blueCuracao, .porcelainRose, .biscay: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.SpanishPalette.allCases.allSatisfy { color in
            switch color {
            case .jacksonsPurple, .c64Purple, .swanWhite, .summerSky, .celestialGreen, .luckyPoint, .liberty, .hotStone, .devilBlue, .palmSpringsSplash, .fluorescentRed, .syntheticPumpkin, .crocodileTooth, .mandarinSorbet, .spicedButternut, .eyeOfNewt, .chileanFire, .greyPorcelain, .alamedaOchre, .desert: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.SwedishPalette.allCases.allSatisfy { color in
            switch color {
            case .highlighterPink, .darkPeriwinkle, .megaman, .freshTurquoise, .mintyGreen, .sizzlingRed, .freeSpeechBlue, .spiroDiscoBall, .jadeDust, .greenTeal, .nârenjiOrange, .yrielYellow, .sunsetOrange, .hintOfElusiveBlue, .goodNight, .chromeYellow, .vibrantYellow, .redOrange, .londonSquare, .blackPearl: return true
            }
        })
        XCTAssertTrue(DHFlatUIColors.TurkishPalette.allCases.allSatisfy { color in
            switch color {
            case .brightLilac, .prettyPlease, .lightRed, .mandarinSorbet, .unmellowYellow, .lightPurple, .youngSalmon, .redOrange, .radiantYellow, .dornYellow, .wintergreen, .electricBlue, .neonBlue, .lightSlateBlue, .shadowedSteel, .weirdGreen, .hammamBlue, .spiroDiscoBall, .lightIndigo, .balticSea: return true
            }
        })
    }
}
